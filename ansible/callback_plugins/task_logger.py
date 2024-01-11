#!/usr/bin/env python3
""" task auditing callback pluging
    Author:  Jose Lima (jlima)
    Date:    2024-01-10  21:01

    This callback module interceps task events and creates a log file with each
    task's final status and errors. 

    Tasks that are set to "ignore_errors: true" are not logged due to the nature
    of the ignore_errors directive.

    To skip logging any task output/errors that could leak sensitive data mark
    there are two ways supported to skip logging task ouput (but still report failure):

    1. Set a tag named sensitive

    - name: Set the super secret password
      ansible.builtin.shell: echo password123
      tags:
       - sensitive

    2. Or set a variable named sensitive directly on the task

    - name: Set the super secret password
      ansible.builtin.shell: echo password123
      vars:
        sensitive: true

     Setting variable named sensitive globaly will basically ignore all output
     but still report a failure and the task name, probaly should be avoided.

"""

import logging
from ansible.plugins.callback import CallbackBase

logging.basicConfig(
    filename="ansible_tasks.log",
    level=logging.INFO,
    format="%(asctime)s: %(message)s",
    filemode="w",
)
logger = logging.getLogger(__name__)


def process_error(message):
    start = "#" * 19 + " ERROR " + "#" * 19
    end = "#" * 20 + " END " + "#" * 20
    return f"\n{start}\n\n{message}\n\n{end}\n"


def get_last_lines(message, offset):
    """returns the last x(offset) lines of a long string(message)"""
    lines = message.splitlines()
    last_lines = lines[-offset:]
    return "\n".join(last_lines)


class CallbackModule(CallbackBase):
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "notification"
    CALLBACK_NAME = "task_logger"

    def is_sensitive_task(self, result):
        """
        Check if 'sensitive' is defined in task vars
        or if the task has a tag called sensitive
        """
        return (
            result._task.vars.get("sensitive", False)
            or "sensitive" in result._task.tags
        )

    # def log_warnings(self, task, warnings):
    #     for warning in warnings:
    #         logger.warning(f"Status: OK - Task: {task.name} - INFO - {warning}")

    def v2_runner_on_ok(self, result):
        if result._result.get("failed", False):
            return  # Skip logging failed events
        # warnings = result._result.get("warnings", [])
        task = result._task
        # if warnings:
        #     self.log_warnings(task, warnings)
        #     return
        logger.info(f"Status: OK - Task: {task.name}")

    def v2_runner_on_failed(self, result, ignore_errors=False):
        if ignore_errors or result._task_fields.get("ignore_errors", False):
            return  # Skip logging for tasks with "ignore_errors: true"
        task = result._task
        msg_queue = [
            result._result.get("stdout", ""),
            result._result.get("stderr", ""),
            result._result.get("msg", ""),
        ]
        _raw = "\n".join([get_last_lines(x, 10) for x in msg_queue if len(x) > 0])

        msg = process_error(_raw)

        if self.is_sensitive_task(result):
            logger.error(
                f"Status: *FAILED* - Task: {task.name} - failed log <marked_sensitive>"
            )
        else:
            logger.error(
                f"Status: *FAILED* - Task: {task.name} - failed with error:\n{msg}"
            )
