sqlplus / as sysdba


@?/rdbms/admin/cdenv.sql

set line 240
COL PROFILE FOR a25
COL RESOURCE_NAME FOR a35
COL RESOURCE_TYPE FOR a15
COL LIMIT FOR a35
select PROFILE 
, RESOURCE_NAME
, RESOURCE_TYPE
, LIMIT 
from dba_profiles
where 
  -- RESOURCE_NAME='SESSIONS_PER_USER'
  PROFILE='DEFAULT'
/

alter profile DEFAULT limit PASSWORD_ROLLOVER_TIME 0;
