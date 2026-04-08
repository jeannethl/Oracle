SQL> select 'spool homologacion_permisologia.lst' from dual;
spool homologacion_permisologia.lst
SQL> select 'set timi on ' from dual;
set timi on
SQL> select 'set time on ' from dual;
set time on
SQL> select ' ' from dual;

SQL> 
SQL>  select *
  2   from (
  3   select 'grant '||PRIVILEGE||' on '||OWNER||'.'||TABLE_NAME||' to '||GRANTEE||';'
  4   from dba_tab_privs@BDVEMPD
  5   where GRANTEE not IN  ('SYS','SYSTEM','DBA','PUBLIC','PERFSTAT','SELECT_CATALOG_ROLE','OLAPI_TRACE_USER','OLAPSYS','OWF_MGR','XDBADMIN','DMSYS','WMSYS'
  6   ,'HS_ADMIN_ROLE'
  7   ,'IMP_FULL_DATABASE'
  8   ,'AQ_ADMINISTRATOR_ROLE'
  9   ,'AQ_USER_ROLE'
 10   ,'EXECUTE_CATALOG_ROLE'
 11   ,'EXP_FULL_DATABASE'
 12   ,'EXECUTE_CATALOG_ROLE'
 13   ,'CTXSYS'
 14   ,'SI_INFORMTN_SCHEMA'
 15   ,'TSMSYS'
 16   ,'XDB'
 17   ,'OUTLN'
 18   ,'MDSYS'
 19   ,'EXFSYS')
 20   minus
 21   select 'grant '||PRIVILEGE||' on '||OWNER||'.'||TABLE_NAME||' to '||GRANTEE||';'
 22   from dba_tab_privs
 23   where GRANTEE not IN  ('SYS','SYSTEM','DBA','PUBLIC','PERFSTAT','SELECT_CATALOG_ROLE','OLAPI_TRACE_USER'
 24   ,'OLAPSYS','OWF_MGR','XDBADMIN','DMSYS','WMSYS'
 25   ,'HS_ADMIN_ROLE'
 26   ,'IMP_FULL_DATABASE'
 27   ,'AQ_ADMINISTRATOR_ROLE'
 28   ,'AQ_USER_ROLE'
 29   ,'EXECUTE_CATALOG_ROLE'
 30   ,'EXP_FULL_DATABASE'
 31   ,'EXECUTE_CATALOG_ROLE'
 32   ,'CTXSYS'
 33   ,'SI_INFORMTN_SCHEMA'
 34   ,'TSMSYS'
 35   ,'XDB'
 36   ,'OUTLN'
 37   ,'MDSYS'
 38   ,'EXFSYS')
 39   );
grant EXECUTE on SYS.DBMS_CRYPTO to BDVEMP;
grant EXECUTE on SYS.DBMS_DATAPUMP to BDVEMP;
grant EXECUTE on SYS.DBMS_JOB to SEGURIDAD_INFORMATICA;
grant EXECUTE on SYS.DBMS_TRANSACTION to SEGURIDAD_INFORMATICA;
grant READ on SYS.EXPORT to BDVEMP;
grant SELECT on SYS.DBA_DIRECTORIES to BDVEMP;
grant SELECT on SYS.DBA_TAB_PARTITIONS to BDVEMP;
grant SELECT on SYS.DBA_TAB_SUBPARTITIONS to BDVEMP;
grant WRITE on SYS.EXPORT to BDVEMP;
SQL> 
SQL>  select ' ' from dual;

SQL>  select 'spool off ' from dual;
spool off
SQL> 
SQL>  spool off
