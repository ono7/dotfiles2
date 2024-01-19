#!/usr/bin/env python3
""" task auditing callback pluging

    Author:  Jose Lima (jlima)
    Date:    2024-01-10  21:01

    NOTE: **Do not print() in the callback plugin**

    # set stdout to default in ansible.cfg
    [defaults]
    stdout_callback = default

    DESCRIPTION:

    This callback module interceps task events and creates a log file with each
    task's final status and errors.

    Tasks that are set to "ignore_errors: true" are not logged due to the nature
    of the ignore_errors directive.

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

import logging
from pathlib import Path
from ansible.plugins.callback import CallbackBase
import json

logging.basicConfig(
    filename="ansible_tasks.log",
    level=logging.INFO,
    # format="[%(levelname)s - %(asctime)s] %(message)s",
    format="[%(asctime)s] %(message)s",
    filemode="a",
)
logger = logging.getLogger(__name__)


_status_fatal = r"[ ❌ FATAL ]"
_status_success =  r"[ ✅ OK ]"
_status_warning = r"[ ✅ WARNING ]"

def wrap_message(message, header="", sep="-"):
    """Error message wrapper"""

    total_len = 90
    header_len = len(header) + 2
    header_padding = (total_len - header_len) // 2
    header = sep * header_padding + header + sep * header_padding

    if len(header) < total_len:
        header += sep

    # sep = "" # disabled for now 2024-01-19 15:18
    footer_text = sep
    footer_padding = (total_len - len(footer_text)) // 2
    footer = sep * footer_padding + footer_text + sep * footer_padding

    if len(footer) < total_len:
        footer += sep
    return f"\n{header}\n\n{message}\n\n{footer}\n"


def get_errors_from_task(result):
    """creates a flat string from results errors
    will appear in the order defined.
    inject custom messages via
    result.setdefault("my_msg", abc)
    """
    msg_queue = [
        result._result.get("my_msg", ""),
        result._result.get("stdout", ""),
        result._result.get("stderr", ""),
        result._result.get("msg", ""),
    ]
    return "\n".join(
        [get_last_lines(split_string(x), 25) for x in msg_queue if len(x) > 0]
    )


def get_last_lines(message, offset):
    """returns the last x(offset) number of lines from a long string(message)"""
    lines = message.splitlines()
    last_lines = lines[-offset:]
    return "\n".join(last_lines)


def split_string(s, chunk_size=100):
    """make long log lines more presentable in RITM/SCTASK"""
    return "\n".join(s[i : i + chunk_size] for i in range(0, len(s), chunk_size))


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
        """not implemented, this could get noisy, only report failures"""
        pass

    def v2_runner_item_on_failed(self, result):
        """report failed items in loop/with_items"""
        item = result._result["item"]
        if self.is_sensitive_task(result):
            msg = "marked sensitive"
        else:
            result._result.setdefault("my_msg", item)
            _raw = get_errors_from_task(result)
            msg = wrap_message(_raw, header=_status_fatal)
        logger.error(
            f"{_status_fatal} ({self.playbook_name}) Task(loop): {result.task_name} \n{msg}"
        )

    def v2_runner_on_failed(self, result, ignore_errors=False):
        task = result._task
        _raw = get_errors_from_task(result)
        msg = wrap_message(_raw, header=_status_fatal)

        if self.is_sensitive_task(result):
            logger.error(
                f"{_status_fatal} ({self.playbook_name}) Task: {task.name} <log_marked_sensitive>"
            )
        elif result._task_fields.get("ignore_errors", False):
            msg = wrap_message(_raw, header=_status_warning)
            logger.warn(f"{_status_success} ({self.playbook_name}) Task: {task.name} \n{msg}")
            return

        else:
            logger.error(
                f"{_status_fatal} ({self.playbook_name}) Task: {task.name} \n{msg}"
            )
