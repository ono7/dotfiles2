#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-02-19  16:54

    .tables;
    select * from task_result;
    select * from task_results where result regexp '\d';
    select * from task_results where result regexp 'error';

"""
from ansible.plugins.callback import CallbackBase
import sqlite3
import json
import logging

# Configure logging
logging.basicConfig(
    filename="sqlite_logger.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)


def initialize_db(db_path):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    create_table_query = """
    CREATE TABLE IF NOT EXISTS task_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        host TEXT NOT NULL,
        task_name TEXT NOT NULL,
        status TEXT NOT NULL,
        result TEXT,
        time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    """
    cursor.execute(create_table_query)
    conn.commit()
    cursor.close()
    conn.close()


class CallbackModule(CallbackBase):
    def __init__(self):
        super(CallbackModule, self).__init__()
        self.db_path = "ansible_results.db"
        initialize_db(self.db_path)
        self.conn = sqlite3.connect(self.db_path)
        self.cursor = self.conn.cursor()

    def __del__(self):
        self.conn.close()

    def log_task(self, task, status, result):
        try:
            self.cursor.execute(
                "INSERT INTO task_results (host, task_name, status, result) VALUES (?, ?, ?, ?)",
                (
                    task._host.get_name(),
                    task._task.get_name(),
                    status,
                    json.dumps(result["msg"]),
                ),
            )
            self.conn.commit()
            logging.info(f"Task logged: {task._task.get_name()}, Status: {status}")
        except sqlite3.Error as e:
            self.conn.rollback()
            logging.error(f"Error inserting task result: {e}")

    def v2_runner_on_ok(self, result, **kwargs):
        self.log_task(result, "OK", result._result)

    def v2_runner_on_failed(self, result, **kwargs):
        self.log_task(result, "FAILED", result._result)

    def v2_playbook_on_stats(self, stats):
        self.conn.close()
