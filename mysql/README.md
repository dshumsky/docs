##### Info
```shell script
mysql -h HOST -u admin -p

show databases;
create database DB;
use DB;
show tables;

show status where `variable_name` = 'Threads_connected';
show processlist;
```

##### Logging
```shell script
mysql> SHOW VARIABLES LIKE "general_log%";
mysql> SET GLOBAL general_log = 'ON';
less $general_log_file
```

##### Dump

```shell script
mysqldump \
  --databases DB \
  --triggers --routines \
  --set-gtid-purged=OFF \
  -h host -u admin -p -r "/tmp/dump.sql"

mysql -h HOST -u admin -p < /tmp/dump.sql
```
