#!/usr/bin/env python3
""" task auditing callback pluging

    Author:  Jose Lima (jlima)
    Date:    2024-01-10  21:01

    NOTE: **Do not print() in the callback plugin**

    # set stdout to default in ansible.cfg
    [defaults]
    stdout_callback = default

    DESCRIPTION:

    This callback module hooks into ansible events and creates a log entry for each task
    in to a log file that can be used for reporting.

    Tasks that are set to "ignore_errors: true" are set to warn status here since the intent
    is to continue playbook execution when the flag is set.

    To skip logging any task output/errors that could leak sensitive_task data mark
    there are two ways supported to skip logging task ouput (but still report failure):

    1. Set a tag named sensitive_task

    - name: Set the super secret password
      ansible.builtin.shell: echo password123
      tags:
       - sensitive_task

    2. Or set a variable named sensitive_task directly on the task

    - name: Set the super secret password
      ansible.builtin.shell: echo password123
      vars:
        sensitive_task: true

     Setting variable named sensitive_task globaly will basically ignore all output
     but still report a failure and the task name, probaly should be avoided.

"""

from pathlib import Path
from ansible.plugins.callback import CallbackBase
from ansible.executor.task_result import TaskResult
import logging
import os

log_file_name = "ansible_tasks.log"

logging.basicConfig(
    filename=log_file_name,
    level=logging.INFO,
    format="[%(asctime)s] %(message)s",
    filemode="a",
)
logger = logging.getLogger(__name__)


_status_fatal = r"[ ❌ FATAL ]"
_status_success = r"[ ✅ OK ]"
_status_warning = r"[ ✅ WARNING ]"


def wrap_message(message, header="", sep="-"):
    """Error message wrapper"""

    total_len = 100
    header_len = len(header) + 2
    header_padding = (total_len - header_len) // 2
    header = sep * header_padding + header + sep * header_padding

    if len(header) < total_len:
        header += sep

    footer = sep * len(header)
    return f"\n{header}\n\n{message}\n\n{footer}\n"


def get_errors_from_task(result):
    """creates a flat string from results errors
    will appear in the order defined.
    inject custom messages via
    result._result.setdefault("my_msg", abc)
    """
    if isinstance(result, TaskResult):
        msg_queue = [
            result._result.get("my_msg", ""),
            result._result.get("stdout", ""),
            result._result.get("stderr", ""),
            result._result.get("msg", ""),
        ]
        return "\n".join(
            [get_last_lines(split_string(x), 25) for x in msg_queue if len(x) > 0]
        )
    else:
        try:
            msg_queue = [
                result.get("my_msg", ""),
                result.get("stdout", ""),
                result.get("stderr", ""),
                result.get("msg", ""),
            ]
            return "\n".join(
                [get_last_lines(split_string(x), 25) for x in msg_queue if len(x) > 0]
            )
        except Exception as e:
            return f"get_errors_from_task: unable to parse errors, this might be ok... -> {e}, {dir(result)}"


def get_last_lines(message, offset):
    """returns the last x(offset) number of lines from a long string(message)"""
    if isinstance(message, str):
        lines = message.splitlines()
        last_lines = lines[-offset:]
        return "\n".join(last_lines)


def split_string(s, chunk_size=100):
    """make long log lines more presentable in RITM/SCTASK"""
    if isinstance(s, str):
        if len(s) > chunk_size:
            return "\n".join(
                s[i : i + chunk_size] for i in range(0, len(s), chunk_size)
            )
        return "\n" + s
    if isinstance(s, list):
        s = "\n".join(x for x in s if isinstance(s, str))
        return split_string(s)
    return s


class CallbackModule(CallbackBase):
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "notification"
    CALLBACK_NAME = "task_logger"

    def __init__(self):
        super(CallbackModule, self).__init__()
        self.playbook_name = None

    def v2_playbook_on_start(self, playbook):
        file = Path(playbook._file_name)
        if file:
            self.playbook_name = file.with_suffix("")

    def is_sensitive_task(self, result):
        """If the task contains sensitive information <secrets>, it should be marked sensitive_task, see module doc string"""
        return (
            result._task.vars.get("sensitive_task", False)
            or "sensitive_task" in result._task.tags
        )

    def v2_runner_on_ok(self, result):
        if result._result.get("failed", False):
            return  # Skip logging failed events
        task = result._task
        logger.info(f"{_status_success} ({self.playbook_name}) Task: {task.name}")

    def v2_runner_item_on_ok(self, result):
        """not implemented, this could get noisy, only report failures for now"""
        pass

    def v2_runner_item_on_failed(self, result):
        """report failed items in loop/with_items"""

        result._result.setdefault(
            "my_msg", f"*** Task(loop): (ignore_errors=True) {result.task_name} ***\n\n"
        )
        _raw = get_errors_from_task(result)

        if self.is_sensitive_task(result):
            msg = "marked sensitive"
        # if the task is set to ignore_errors: true, we want to warn.
        elif result._task_fields.get("ignore_errors", False):
            msg = wrap_message(_raw, header=_status_warning)
            logger.warn(
                f"{_status_success} ({self.playbook_name}) Task(loop): (ignore_errors=True) {result.task_name} \n{msg}"
            )
            return
        else:
            msg = wrap_message(_raw, header=_status_fatal)
        logger.error(
            f"{_status_fatal} ({self.playbook_name}) Task(loop): {result.task_name} \n{msg}"
        )

    def v2_runner_on_failed(self, result, ignore_errors=False):
        """report on failure, result(TaskResult)"""

        task = result._task
        _raw = get_errors_from_task(result)
        msg = wrap_message(_raw, header=_status_fatal)

        if self.is_sensitive_task(result):
            logger.error(
                f"{_status_fatal} ({self.playbook_name}) Task: {task.name} <log_marked_sensitive>"
            )
        # handle tasks that have ignore_errors: true
        elif result._task_fields.get("ignore_errors", False):
            msg = wrap_message(_raw, header=_status_warning)
            logger.warn(
                f"{_status_success} ({self.playbook_name}) Task: (ignore_errors=True) {task.name} \n{msg}"
            )
            return

        else:
            logger.error(
                f"{_status_fatal} ({self.playbook_name}) Task: {task.name} \n{msg}"
            )

    def playbook_on_stats(self, stats):
        """
        Called at the end of playbook execution to modify or set custom stats.
        """
        tower_job_id = os.getenv("JOB_ID", "Not running in AAP")

        with open(log_file_name) as f:
            log_contents = f.read()

        custom_stats = {
            "task_result": "\n\n" + log_contents,
            "task_result_lines": log_contents.splitlines(),
            "job_id": tower_job_id,
        }

        for host in stats.processed.keys():
            stats.summarize(host)
            self._set_stats(custom_stats)

    # def v2_playbook_on_stats(self, stats):
    #     super(CallbackModule, self).v2_playbook_on_stats(stats)
    #     with open(log_file_name) as f:
    #         self._display.display("******** Playbook event summary ********")
    #         self._display.display(f.read())
    #         stats.custom["task_result"] = f.read()
