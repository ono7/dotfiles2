#!/usr/bin/env python3
"""
    Author:  Jose Lima (jlima)
    Date:    2024-02-19  16:54

    This callback logs everything into a sqlite3 table for post playbook parsing
    this can be called as part of a workflow where a job template parses the results from the table
    and generates a report, html etc.

    .tables;
    select * from task_result;
    select * from task_results where result regexp '\d';
    select * from task_results where result regexp 'error';

    sqlite> select count(*) from task_results ;
    ┌──────────┐
    │ count(*) │
    ├──────────┤
    │ 60       │
    └──────────┘
    sqlite> select count(*) from task_results where result REGEXP 'bad';
    ┌──────────┐
    │ count(*) │
    ├──────────┤
    │ 4        │
    └──────────┘
    sqlite> select count(*) from task_results where status == "OK";
    ┌──────────┐
    │ count(*) │
    ├──────────┤
    │ 56       │
    └──────────┘
    sqlite>

"""
from ansible.plugins.callback import CallbackBase
import sqlite3
import json
import logging

# Configure logging
logging.basicConfig(
    filename="sqlite_logger_db.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)


def get_errors_from_task(result):
    """creates a flat string from results errors
    will appear in the order defined.
    inject custom messages via
    result._result.setdefault("my_msg", abc)
    """
    msg_queue = [
        result._result.get("my_msg", ""),
        result._result.get("stdout", ""),
        result._result.get("stderr", ""),
        result._result.get("msg", ""),
    ]
    return "\n".join(
        [get_last_lines(normalize_string(x), 25) for x in msg_queue if len(x) > 0]
    )


def get_last_lines(message, offset):
    """returns the last x(offset) number of lines from a long string(message)"""
    if isinstance(message, str):
        lines = message.splitlines()
        last_lines = lines[-offset:]
        return "\n".join(last_lines)


def normalize_string(s):
    """normalize strings or list of strings"""
    if isinstance(s, str):
        return "\n" + s
    if isinstance(s, list):
        s = "\n".join(x for x in s if isinstance(s, str))
        return normalize_string(s)
    return s


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
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "notification"
    CALLBACK_NAME = "sqlite_logger"

    def __init__(self):
        super(CallbackModule, self).__init__()
        self.db_path = "ansible_results.db"
        initialize_db(self.db_path)

    def log_task(self, status, result):
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        try:
            cursor.execute(
                "INSERT INTO task_results (host, task_name, status, result) VALUES (?, ?, ?, ?)",
                (
                    result._host.get_name(),
                    result._task.get_name(),
                    status,
                    json.dumps(get_errors_from_task(result)),
                ),
            )
            conn.commit()
        except sqlite3.Error as e:
            conn.rollback()
            logging.error(f"Error inserting task result: {e}")

    def v2_runner_item_on_failed(self, result):
        self.log_task("FAILED", result)

    def v2_runner_on_ok(self, result, **kwargs):
        self.log_task("OK", result)

    def v2_runner_on_failed(self, result, **kwargs):
        self.log_task("FAILED", result)

    def v2_runner_on_unreachable(self, result):
        self.log_task("FAILED", result)
        """report when host is not reachable, result(TaskResult)"""
