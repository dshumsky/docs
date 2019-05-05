
#### Queries
- Find object by name
  ```
  select * from ALL_OBJECTS where OBJECT_NAME = 'OBJECT_NAME'
  ```
- Get DDL
  ```
  SELECT DBMS_METADATA.GET_DDL('OBJECT_TYPE','OBJECT_NAME'[,'OWNER']) FROM DUAL
  --
  select dbms_metadata.get_ddl('TABLE', o.OBJECT_NAME),';'
  from user_objects o 
  where OBJECT_TYPE='TABLE' and o.OBJECT_NAME in ('TABLE_NAME');
  ```
- Tables referenced to the current
  ```
  select * from user_constraints where CONSTRAINT_NAME='SYS_C00365462';
  --
  select fk.TABLE_NAME, fk.CONSTRAINT_NAME, fk.CONSTRAINT_TYPE, fk.R_CONSTRAINT_NAME, cc.COLUMN_NAME
  from user_constraints fk
  inner join user_constraints pk on pk.CONSTRAINT_TYPE='P' 
                                and pk.TABLE_NAME='COUNTRY' 
                                and pk.CONSTRAINT_NAME=fk.R_CONSTRAINT_NAME
  inner join user_cons_columns cc on cc.TABLE_NAME=fk.TABLE_NAME 
                                 and cc.CONSTRAINT_NAME=fk.CONSTRAINT_NAME
  where fk.CONSTRAINT_TYPE='R'
  order by fk.TABLE_NAME;
  ```
- Running quires
  ```
  select t.FIRST_LOAD_TIME, t.* from gv$sql t
  where t.SQL_TEXT like 'UPDATE T%'
  order by t.FIRST_LOAD_TIME desc;
  --
  SELECT * FROM v$sql_bind_capture
  where SQL_ID in ('bcz2c14ut3hyb');
  ```
