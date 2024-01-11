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
    file_mode = 'w'
)
logger = logging.getLogger(__name__)

class CallbackModule(CallbackBase):
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "notification"
    CALLBACK_NAME = "task_logger"

    def v2_runner_on_ok(self, result):
        if result._result.get("failed", False):
            return  # Skip logging here as it will be logged in on_failed
        task = result._task
        logger.info(f"Status: OK - Task: {task.name} - executed successfully")

    def v2_runner_on_failed(self, result, ignore_errors=False):
        task = result._task
        msg = result._result.get("msg") or result._result.get("stdout")
        logger.error(f"Status: *** FAILED *** - Task: {task.name} - failed with error: {msg}")
