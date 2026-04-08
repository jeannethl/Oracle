Migracion:
--editar los nombres de los archivos
01_parfile_expdp_trzsp_full.par
02_parfile_expdp_table_doerextmsg.par
03_parfile_expdp_metadata_rdx_eventlog.par

04_parfile_imp_metadata.par
05_parfile_imp_metadata_dem.par
06_parfile_imp_metadata_eventlog.par

07_disable_trigger.sql
08_create_dml_parallel_trigger.sql

09_parfile_imp_data.par
10_parfile_imp_data_dem.par

11_enable_trigger.sql

12_ddl_index_lotes.sh

13_ddl_constraints_lotes.sh
14_ddl_constraints_lotes.sh
15_homologacion_columns_tables.sql

16_create_procedure_kill_database_session.sql
17_homologacion_permisologia.sql
18_exec_homologacion_permisologia.sql
19_verificar_objetos_invalidos.sql
20_compilar_objetos_invalidos.sql
21_verificar_objetos_invalidos.sql
22_dba_registry.sql

23_validar_usuarios.sql
24_comparar_tbs.sql
25_comparar_objetos.sql
26_estadisticas.sql

***************************************************************************************************************
***************************************************************************************************************
*Monitoreo --Ambos Servidores Abrir una ventana para cada monitoreo.

*Log Base de Datos

*VMSTAT
vmstat 5 1000000

*IOSTAT
while true; do iostat -d -x 2 2 | sort -n -k 11; sleep 5; echo ------- ; done

*Operaciones Largas
cd /Migracion3/TRZS/scripts/Monitoreo
sqlplus / as sysdba @show_long_operation.sql

*Status del JOB


 
IMPDP
while true; do egrep -i DOER_2024 IMP_DATA_TRZS_1.LOG; sleep 60; clear; done

while true; do egrep -i "TRAN\":\"TRAN_2024_|DOER_2024_" EXPDP_FULL_TRZS_1.LOG|sort -k7; sleep 30; clear; done


***
 egrep -i "TRAN\":\"TRAN_2024_|DOER_2024_" EXPDP_FULL_TRZS_1.LOG | awk '{ print $7}'| awk -F. '{ print $2}' | awk -F: '{ print $1 }' 





***************************************************************************************************************
***************************************************************************************************************

*servidor sun1120p   =========EXPORT===========
cd /Migracion3/TRZS/scripts/Export

01_parfile_expdp_trzsp_full.sql

FULL
nohup expdp system/bdv23ccs2 parfile=01_parfile_expdp_trzsp_full.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01


DOEREXTMSG
nohup expdp system/bdv23ccs2 parfile=02_parfile_expdp_table_doerextmsg.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01

EXPDP_METADATA_RDX_EVENTLOG

nohup expdp system/bdv23ccs2 parfile=03_parfile_expdp_metadata_rdx_eventlog.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01


--EXP_BALANCEHIST
--
--nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_balancehist.par &
--
--expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01


cd /Migracion3/TRZS/EXP_FULL_TRZS
EXPDP
while true; do egrep -i BALANCEHIST_20 IMP_DATA_TRZS_1.LOG |wc -l; sleep 30; clear; done
while true; do egrep -i "TRAN\":\"TRAN_2024_" EXPDP_FULL_TRZS_1.LOG; sleep 30; clear; done

***Mover los archivos .dmp generados a sus respectivas carpetas y dar permisos 777 a cada una

***************************************************************************************************************
***************************************************************************************************************


*servidor 172.27.70.66   =========IMPORT===========


-->SQL
--alter system set "_OPTIMIZER_GATHER_STATS_ON_LOAD"=false comment=' Best practice Datapumo import'
--
--alter system set "_lm_share_lock_opt"=FALSE comment=' Best practice Datapumo import' scope=spfile; 

--BAJAR LISTENER NODO1 sun1120p
--srvctl stop listener -l LISTENER

cd /Migracion3/TRZS/scripts/Import
==METADATA
*FULL
nohup impdp system/oracle1 parfile=04_parfile_imp_metadata.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


*DOEREXTMSG
nohup impdp system/oracle1 parfile=05_parfile_imp_metadata_dem.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


*EVENTLOG
nohup impdp system/oracle1 parfile=06_parfile_imp_metadata_eventlog.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

*BALANCEHIST
nohup impdp system/oracle1 parfile= parfile_imp_metadata_balancehist.par &


===INDEXES
*BALANCEHIST
nohup impdp system/oracle1 parfile=parfile_extract_ddl_PK_BALANCEHIST.par &

nohup impdp system/oracle1 parfile=parfile_extract_ddl_IDX_BALANCEHIST_ACCOUNT.par &

DUMPFILE=EXP_BALANCEHIST_TRZS_%L.dmp
***Para el proximo EXPORT modificar el parfile
DUMPFILE=EXP_FULL_TRZS_%L.dmp


*THREADEDJOB
nohup impdp system/oracle1 parfile=parfile_extract_ddl_index_PK_RDX_JS_THREADEDJOBPARAM.par &

nohup impdp system/oracle1 parfile=parfile_extract_ddl_index_IDX_RDX_JS_THREADEDJOB_NEXT.par &

nohup impdp system/oracle1 parfile=parfile_extract_ddl_index_PK_RDX_JS_THREADEDJOB.par &

--nohup impdp system/oracle1 parfile=parfile_extract_ddl_constraint_balancehist.par &
--
--impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01
--
--novalidate**

*Deshabilitar y crear triggers
cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG
>SQL

@07_disable_trigger.sql
@08_create_dml_parallel_trigger.sql


*Import Data
cd /Migracion3/TRZS/scripts/Import
FULL
nohup impdp system/oracle1 parfile=09_parfile_imp_data.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


=============================
*Modificar ARCHIVOS INDEX --Mientras corre el import de la data (50 min aprox)
cd /Migracion3/TRZS/EXP_FULL_TRZS

chmod 777 *.sql

mv ddl_index_trzsp_full_*.sql /Migracion3/TRZS/scripts/IDX_CONST_TRGG/
--cp -p ddl_constraint_trzsp_balancehist.sql /Migracion3/TRZS/scripts/IDX_CONST_TRGG/ddl_constraint_trzsp_balancehist.sql

==============================
cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

vi ddl_index_trzsp_full_18.sql
 spool ddl_index_trzsp_full_18.lst

set time on timi on

-- CONNECT SYSTEM
ALTER SESSION SET EVENTS '10150 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10904 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '25475 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10407 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10851 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '22830 TRACE NAME CONTEXT FOREVER, LEVEL 192 ';
-- new object type path: TABLE_EXPORT/TABLE/INDEX/INDEX
-- CONNECT TX
alter session set sort_area_size=500000000;
prompt CREATE UNIQUE INDEX "TX"."PK_BALANCEHIST" ON "TX"."BALANCEHIST" ("DAY", "ACCOUNTID")


==============================
vi ddl_index_trzsp_full_19.sql
spool ddl_index_trzsp_full_19.lst
set time on timi on


-- CONNECT SYSTEM
ALTER SESSION SET EVENTS '10150 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10904 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '25475 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10407 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10851 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '22830 TRACE NAME CONTEXT FOREVER, LEVEL 192 ';
-- new object type path: TABLE_EXPORT/TABLE/INDEX/INDEX
-- CONNECT TX
alter session set sort_area_size=500000000;
prompt CREATE INDEX "TX"."IDX_BALANCEHIST_ACCOUNT" ON "TX"."BALANCEHIST" ("ACCOUNTID", "DAY")


--vi ddl_constraint_trzsp_balancehist.sql
--
--spool ddl_constraint_trzsp_balancehist.lst
--set time on timi on


=================================
vi ddl_index_trzsp_full_22.sql

spool ddl_index_trzsp_full_22.lst
prompt - ddl_index_trzsp_full_22
set time on timi on

-- CONNECT SYSTEM
ALTER SESSION SET EVENTS '10150 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10904 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '25475 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10407 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10851 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '22830 TRACE NAME CONTEXT FOREVER, LEVEL 192 ';
alter session set sort_area_size=500000000;

prompt CREATE UNIQUE INDEX "TX"."PK_RDX_JS_THREADEDJOBPARAM" ON "TX"."RDX_JS_THREADEDJOB" ("JOBDUETIME", "JOBID", "NAME")

=================================
vi ddl_index_trzsp_full_23.sql

spool ddl_index_trzsp_full_23.lst
set time on timi on


-- CONNECT SYSTEM
ALTER SESSION SET EVENTS '10150 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10904 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '25475 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10407 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10851 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '22830 TRACE NAME CONTEXT FOREVER, LEVEL 192 ';
-- new object type path: DATABASE_EXPORT/SCHEMA/TABLE/INDEX/INDEX
-- CONNECT TX

alter session set sort_area_size=500000000;

prompt CREATE INDEX "TX"."IDX_RDX_JS_THREADEDJOB_NEXT" ON "TX"."IDX_RDX_JS_THREADEDJOB" ("AADCMEMBERID", "EXECUTORID", "FINISHED", "EFFECTIVETHREADID", "DUETIME", "ID")


=================================
vi ddl_index_trzsp_full_24.sql

spool ddl_index_trzsp_full_24.lst
set time on timi on

-- CONNECT SYSTEM
ALTER SESSION SET EVENTS '10150 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10904 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '25475 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10407 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '10851 TRACE NAME CONTEXT FOREVER, LEVEL 1';
ALTER SESSION SET EVENTS '22830 TRACE NAME CONTEXT FOREVER, LEVEL 192 ';
-- new object type path: DATABASE_EXPORT/SCHEMA/TABLE/INDEX/INDEX
-- CONNECT TX
prompt CREATE UNIQUE INDEX "TX"."PK_RDX_JS_THREADEDJOB" ON "TX"."RDX_JS_THREADEDJOB" ("DUETIME", "ID")




==================================
cd /Migracion3/TRZS/scripts/Import

*DOEREXTMSG
nohup impdp system/oracle1 parfile=10_parfile_imp_data_dem.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

*BALANCEHIST
nohup impdp system/oracle1 parfile=parfile_imp_data_balancehist.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

while true; do egrep -i BALANCEHIST IMP_DATA_BH_TRZS_1.LOG | wc -l; sleep 30; clear; done


***** Modificar el parfile para el proximo export 


--***********BD_SUN1120p 
--****bajar los dos nodos trzsp1 y trzsp3 bd y luego subir trzsp1 read only
--v$database***

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

*Habilita trigger
>SQL

@11_enable_trigger.sql


/bash

nohup ./12_ddl_index_lotes.sh &

while true
do
ps -ef | grep -i "ddl_index" | grep -v grep
echo "--------------------------------"
date
sleep 5
done




nohup ./13_ddl_constraints_lotes.sh &

while true
do
ps -ef | grep -i "ddl_const" | grep -v grep
date
echo "-----------------------------"
sleep 5
done

nohup ./14_ddl_constraints_lotes.sh &

-->SQL
--@15_homologacion_columns_tables.sql


cd /Migracion3/TRZS/scripts/OBJETOS_INVALIDOS

>SQL   

@16_create_procedure_kill_database_session.sql

@17_homologacion_permisologia.sql

@18_exec_homologacion_permisologia.sql

@19_verificar_objetos_invalidos.sql

@20_compilar_objetos_invalidos.sql

@21_verificar_objetos_invalidos.sql

@22_dba_registry.sql


cd /Migracion3/TRZS/scripts

>SQL

@23_validar_usuarios.sql

@24_comparar_tbs.sql

@25_comparar_objetos.sql

=====================================================================

*Normalizar parametros posterior a la migracion

172.27.70.66
>SQL
--DROPEAR TRIGGER CREADO
DROP TRIGGER  enable_parallel_dml_trigger;

--Parametros ocultos
alter system set "_OPTIMIZER_GATHER_STATS_ON_LOAD"=TRUE comment=' Best practice Datapumo import';

alter system set "_lm_share_lock_opt"=TRUE comment=' Best practice Datapumo import' scope=spfile; 

--CLUSTER_DATABASE
alter system set cluster_database=FALSE scope=spfile;

--FLASHBACK
ALTER DATABASE FLASHBACK ON;

--ARCHIVELOG
archive log list;

shutdown immediate;

startup mount;

alter database archivelog;

alter database open;

archive log list;



/
srvctl status database -d TRZSP
srvctl stop database -d TRZSP
srvctl start database -d TRZSP



cd /Migracion3/TRZS/scripts/OBJETOS_INVALIDOS
>SQL

@26_estadisticas.sql

********
70.66

alter system set session_cached_cursors=8192 scope=spfile;


alter system set cursor_sharing=FORCE;









