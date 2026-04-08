-- PROCEDIMIENTO REBUILD DATAPUMP
-- Consiste en realizar un rebuild del utilitario de DataPump en la Base de Datos, ya que en la misma se encuentra corrupto.
-- 19-06-2024 --
--------------------------------------
-- VERIFICACION DE OBJETOS INVALIDOS
--------------------------------------
set pagesize 500
set linesize 500
col owner format a30
col object_name format a30
select owner, object_name, status
from sys.dba_objects where
status = 'INVALID'
and owner in ('SYS','SYSTEM')
order by 1;
---------------------------------------------------------
-- BAJO NOTA DE ORACLE N° (Doc ID 430221.1)
---------------------------------------------------------
-- 1. Rebuild the DataPump packages with the following steps.

Under the ORACLE_HOME, execute:
cd $ORACLE_HOME/rdbms/admin

-- run SQL*Plus as sysdba

@dpload.sql


-- 2. To recompile  invalid objects, if any

SQL> @$ORACLE_HOME/rdbms/admin/utlrp.sql
---------------------------------------------------------
---------------------------------------------------------


---------------------------------------------------------
-- EN CASO DE NECESITAR VERIFICAR EL REGISTRY
---------------------------------------------------------

SET PAGESIZE 100
SET LINESIZE 180
SET VERIFY OFF
COL comp_id FOR a15 HEA 'Component ID' 
COL comp_name FOR a40 HEA 'Component' 
COL version FOR a17 HEA 'Version' 
COL status FOR a10 HEA 'Status' 
SELECT comp_id
, comp_name
, version
, status FROM dba_registry
/