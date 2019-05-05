
#### Queries
- Find object by name
  ```
  select * from ALL_OBJECTS where OBJECT_NAME = 'OBJECT_NAME'
  ```
- Get DDL
  ```
  SELECT DBMS_METADATA.GET_DDL('OBJECT_TYPE','OBJECT_NAME'[,'OWNER']) FROM DUAL
  ```
- Tables referenced to the current
  ```
  select * from user_constraints where CONSTRAINT_NAME='SYS_C00365462';

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
