-- sqlcmd -S "host,1433" -U admin -P 'password'

select name from sys.databases;

use db;

-- list users in current db
select name as username,
       create_date,
       modify_date,
       type_desc as type,
       authentication_type_desc as authentication_type
from sys.database_principals
where type not in ('A', 'G', 'R', 'X')
      and sid is not null
      and name != 'guest'
order by username;

-- list tables
select distinct table_name from information_schema.tables;

