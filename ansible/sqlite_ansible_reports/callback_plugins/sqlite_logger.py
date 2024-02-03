from ansible.plugins.callback import CallbackBase
import sqlite3
import json


def initialize_db(db_path):
    # Connect to the SQLite database
    conn = sqlite3.connect(db_path)

    # Create a cursor object
    cursor = conn.cursor()

    # SQL command to create the table if it doesn't exist
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

    # Execute the SQL command
    cursor.execute(create_table_query)

    # Commit the changes and close the connection
    conn.commit()
    cursor.close()
    conn.close()


class CallbackModule(CallbackBase):
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "aggregate"
    CALLBACK_NAME = "sqlite_logger"
    CALLBACK_NEEDS_WHITELIST = False

    def __init__(self):
        super(CallbackModule, self).__init__()
        self.db_path = "ansible_results.db"  # Path to your SQLite database
        initialize_db(self.db_path)
        self.conn = sqlite3.connect(self.db_path)
        self.cursor = self.conn.cursor()

    def log_task(self, task, status, result):
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

    def v2_runner_on_ok(self, result, **kwargs):
        self.log_task(result, "OK", result._result)

    def v2_runner_on_failed(self, result, **kwargs):
        self.log_task(result, "FAILED", result._result)

    def v2_playbook_on_stats(self, stats):
        self.conn.close()
