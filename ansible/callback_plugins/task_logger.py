#!/usr/bin/env python3
"""log tasks for better reporting
    Author:  Jose Lima (jlima)
    Date:    2024-01-10  21:01
"""

import logging
from ansible.plugins.callback import CallbackBase

logging.basicConfig(
    filename="ansible_tasks.log",
    level=logging.INFO,
    format="%(asctime)s: %(message)s",
    filemode="w",  # Corrected from file_mode to filemode
)
logger = logging.getLogger(__name__)


def process_error(message):
    start = "#" * 19 + " ERROR " + "#" * 19
    end = "#" * 20 + " END " + "#" * 20
    return f"\n{start}\n\n{message}\n\n{end}\n"


class CallbackModule(CallbackBase):
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "notification"
    CALLBACK_NAME = "task_logger"

    def is_sensitive_task(self, result):
        # Check if 'sensitive_task' is defined in task vars
        return result._task.vars.get("sensitive_task", False)

    def v2_runner_on_ok(self, result):
        if result._result.get("failed", False):
            return  # Skip logging failed events
        task = result._task
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
        _raw = "\n\n".join([x for x in msg_queue if len(x) > 0])

        msg = process_error(_raw)

        if self.is_sensitive_task(result):
            logger.error(
                f"Status: *FAILED* - Task: {task.name} - failed log <marked_sensitive>"
            )
        else:
            logger.error(
                f"Status: *FAILED* - Task: {task.name} - failed with error:\n{msg}"
            )
