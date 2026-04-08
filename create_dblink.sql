CREATE DATABASE LINK TX_SUN
CONNECT TO system IDENTIFIED BY bdv23ccs2
USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = SUN011SCAN)(PORT = 1560))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = TRZSP)
    )
  )';



CREATE DATABASE LINK BDVNET
CONNECT TO system IDENTIFIED BY k3r3p4kup41
USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = sun004scan)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = BDVNETP.BANVENEZ.CORP)
    )
  )';





SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
BEGIN
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/

spool index_faltantes.sql
SELECT dbms_metadata.get_ddl('INDEX',index_name,'BDVNET') from (
select owner, index_name
from DBA_INDEXES
where OWNER='BDVNET'
minus 
select owner, index_name
from DBA_INDEXES@BDVNET
where OWNER='BDVNET'
);
spool off;



set line 400
col owner format a10
col index_name format a30
select *
from (
select owner, index_name
from DBA_INDEXES
where OWNER='BDVNET'
minus 
select owner, index_name
from DBA_INDEXES@BDVNET
where OWNER='BDVNET'
)
order by 1,2;


select *
from (
select OBJECT_NAME
from dba_procedures 
where OWNER='BDVNET'
order by 1;
minus 
select PROCEDURE_NAME
from dba_procedures@BDVNET
where OWNER='BDVNET'
);



set line 400
col CONSTRAINT_NAME format a30
col owner format a10
select *
from (
select owner, CONSTRAINT_NAME
from DBA_CONSTRAINTS
where OWNER='BDVNET'
minus 
select owner, CONSTRAINT_NAME
from DBA_CONSTRAINTS@BDVNET
where OWNER='BDVNET'
)
order by 1,2;






SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
BEGIN
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/

spool constraint_faltantes.sql
SELECT dbms_metadata.get_ddl('CONSTRAINT',CONSTRAINT_NAME,'BDVNET') from (
select owner, CONSTRAINT_NAME
from DBA_CONSTRAINTS
where OWNER='BDVNET'
minus 
select owner, CONSTRAINT_NAME
from DBA_CONSTRAINTS@BDVNET
where OWNER='BDVNET'
);
spool off;






set line 400
col owner format a10
col TABLE_NAME format a30
select *
from (
select owner, TABLE_NAME
from DBA_TABLES
where OWNER='BDVNET'
minus 
select owner, TABLE_NAME
from DBA_TABLES@BDVNET
where OWNER='BDVNET'
)
order by 1,2;

