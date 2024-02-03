# SQLITE

https://charlesleifer.com/blog/going-fast-with-sqlite-and-python/

# REGEXP

```
sqlite> select * from task_results where result REGEXP '\d';
┌────┬───────────┬────────────────────────────────────┬────────┬──────────────────────┬─────────────────────┐
│ id │   host    │             task_name              │ status │        result        │        time         │
├────┼───────────┼────────────────────────────────────┼────────┼──────────────────────┼─────────────────────┤
│ 2  │ localhost │ This task is brittle               │ FAILED │ "this is a test 2\n" │ 2024-02-03 06:02:23 │
│ 3  │ localhost │ Debug html this one works ok       │ OK     │ "this is a test 3\n" │ 2024-02-03 06:02:23 │
│ 4  │ localhost │ Debug html - this is the last task │ OK     │ "this is a test 4\n" │ 2024-02-03 06:02:23 │
└────┴───────────┴────────────────────────────────────┴────────┴──────────────────────┴─────────────────────┘
sqlite>
```

# Open database in autocommit mode by setting isolation_level to None.

conn = sqlite3.connect('app.db', isolation_level=None)

# Set journal mode to WAL.

conn.execute('pragma journal_mode=wal')

## OUPTUT TO CSV FILE

`sqlite3 report.db`

.headers on
.mode csv
.output filename.csv
select \* from table;

## find duplicates

`select host, COUNT(*) c from records GROUP BY host having c >1;`

## describe table

`.schema <table_name>`
