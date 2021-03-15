## secure mysql install

sudo mysql_secure_installation

## macos install

To connect run:
mysql -u root

To have launchd start mysql now and restart at login:
brew services start mysql

Or, if you don't want/need a background service you can just run:
mysql.server start

## create user

```
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';
```

## manage tables

```
show tables;
describe my_table;
```

## insert

```
mysql> INSERT IGNORE INTO person_tbl (last_name, first_name)
   -> VALUES( 'Jay', 'Thomas');
Query OK, 1 row affected (0.00 sec)
```

## update

```
mysql> UPDATE tutorials_tbl
   -> SET tutorial_title = 'Learning JAVA'
   -> WHERE tutorial_id = 3;
```

## unique

```
CREATE TABLE person_tbl (
   first_name CHAR(20) NOT NULL,
   last_name CHAR(20) NOT NULL,
   sex CHAR(10)
   UNIQUE (last_name, first_name)
);
```

## find duplicates

```
SELECT COUNT(*) as repetitions, last_name, first_name
   -> FROM person_tbl
   -> GROUP BY last_name, first_name
   -> HAVING repetitions > 1;
```

## view table engine

```
SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'compliance';
```

## add column field

```
ALTER TABLE inventory
ADD COLUMN reason VARCHAR(50) AFTER failed;

* insert at the beginning
ALTER TABLE inventory ADD COLUMN reason VARCHAR(50) FIRST;

ALTER TABLE findings ADD COLUMN host VARCHAR(100) FIRST;
```

## remove column

`ALTER TABLE table_name DROP COLUMN column_name;`

## alter table size/attribute

`ALTER TABLE inventory MODIFY COLUMN reason VARCHAR(255);`
`ALTER TABLE findings MODIFY COLUMN last_failed date;`
`ALTER TABLE findings_store MODIFY COLUMN last_failed date;`

`ALTER TABLE passed_perm MODIFY COLUMN varchar(100) default NULL;`

## trim field

`UPDATE products SET productname = TRIM(productname);`

## table views inner join

`select host,ip,policy_name from findings inner join inventory using (ip) where ip = '10.86.65.192';`

## provision remote users

`CREATE USER 'user'@'localhost' IDENTIFIED BY 'userpw';`

`GRANT ALL ON compliance.* to 'user'@'1.1.1.1' IDENTIFIED BY 'pw';`

`GRANT ALL ON compliance.* to 'user'@'1.1.1.1' IDENTIFIED BY 'pw' WITH GRANT OPTION;`

`FLUSH PRIVILEGES;`

## create database

`CREATE DATABASE compliance;`

## backup database

`mysqldump -u root -p compliance > compliance_backup_10212020.sql`

## backup database table (findings)

`mysqldump -u root -p compliance findings > compliance_backup_10212020.sql`

## restore database

`mysql -u root -p compliance < compliance_backup_10212020.sql`

## restore database tables (findings)

`mysql -u root -p compliance findings < compliance_backup_10212020.sql`

## delete from table

`DELETE FROM table_name WHERE condition;`

## remove/delete a table;

`DROP TABLE table_name;`

## join

`select host,ip,vendor,conn_handler,last_failed,policy_name from inventory left join findings using(ip) where is_alive='22';`

## clear

`system clear;`

## enable mysql logging

/etc/my.cnf

uncomment two lines

```python
# general_log_file
# general_log
```

## connect to mysql with vars

`mysql -u $DB_USER --password=$DB_PASS -h 10.89.48.134`

mysql 8
`ALTER TABLE inventory RENAME COLUMN owner TO team;`
`ALTER TABLE inventory RENAME COLUMN email TO team_email;`

mysql 5

`ALTER TABLE inventory CHANGE email team_email varchar(150) default '';`

`ALTER TABLE failed_tmp CHANGE last_failed last_checked date;`
`ALTER TABLE failed_perm CHANGE last_failed last_checked date;`

## time range

`select * from findings where last_failed <= now() - INTERVAL 180 DAY;`
`select * from findings where last_failed <= now() - INTERVAL 1 YEAR;`

## delete rows with time range

`DELETE FROM findings_store WHERE last_failed <= NOW() - INTERVAL 180 DAY;`

anything older than 2 days
`SELECT ip,last_failed FROM findings WHERE last_failed >= CURDATE() - INTERVAL 1 DAY;`
`DELETE FROM findings WHERE last_failed >= CURDATE() -INTERVAL 1 DAY;`

## change primary keys

`alter table findings drop primary key, add primary key(ip,policy_name);`
`alter table findings_store drop primary key, add primary key(host,ip,last_failed);`
