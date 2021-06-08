```shell script
psql -U postgres
psql -U admin -W DBNAME

\l - list databases
\c database_name
SELECT current_database();
SELECT current_schema();

DROP SCHEMA public CASCADE;

pg_dump -U admin DBNAME > /tmp/file.sql
pg_restore -U admin -C /tmp/file.sql 


```