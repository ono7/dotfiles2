# SQLITE

https://charlesleifer.com/blog/going-fast-with-sqlite-and-python/

# Open database in autocommit mode by setting isolation_level to None.
conn = sqlite3.connect('app.db', isolation_level=None)

# Set journal mode to WAL.
conn.execute('pragma journal_mode=wal')


## OUPTUT TO CSV FILE

`sqlite3 report.db`

.headers on
.mode csv
.output filename.csv
select * from table;

## find duplicates

`select host, COUNT(*) c from records GROUP BY host having c >1;`
