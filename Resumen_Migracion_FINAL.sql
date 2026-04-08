Migracion:

ORDEN EJECUCION
01.- exports_trzsp


02.- imports_trzsp_metadata

03.- disable_trigger
04.- create_dml_parallel_trigger

05.- imports_data_trzsp
06.- prepare_ddl_index

07.- enable_trigger
08.- ddl_index_lotes
09.- ddl_constraints_lotes
10.- ddl_constraints_lotes
11.- homologacion_degree_parallel

12.- create_procedure_kill_database_session
13.- homologacion_permisologia
14.- exec_homologacion_permisologia
15.- verificar_objetos_invalidos
16.- compilar_objetos_invalidos
17.- verificar_objetos_invalidos
18.- dba_registry

19.- validar_usuarios
20.- comparar_tbs
21.- comparar_objetos
22.- estadisticas


***************************************************************************************************************
***************************************************************************************************************
*Monitoreo

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
cd /Migracion3/TRZS/EXP_FULL_TRZS

while true; do egrep -i DOER_2024 IMP_DATA_TRZS_1.LOG; sleep 60; clear; done

while true; do egrep -i "TRAN\":\"TRAN_2024_|DOER_2024_" EXPDP_FULL_TRZS_1.LOG|sort -k7; sleep 30; clear; done


***
 egrep -i "TRAN\":\"TRAN_2024_|DOER_2024_" EXPDP_FULL_TRZS_1.LOG | awk '{ print $7}'| awk -F. '{ print $2}' | awk -F: '{ print $1 }' 





***************************************************************************************************************
***************************************************************************************************************

--servidor sun1120p   =========EXPORT===========
--d /Migracion3/TRZS/scripts/Export

--ohup ./01_exports_trzsp.sh &

--xpdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01


--cd /Migracion3/TRZS/scripts/Import
--time ./02_generacion_script_create_parfile_index.sh
--
--
--***permisos 777 
--
***********BD_SUN1120p 
--****bajar los dos nodos trzsp1 y trzsp3 bd y luego subir trzsp1 read only
--v$database***
srvctl status database -d TRZSP
srvctl stop database -d TRZSP
--shutdown immediate;
startup read only;



EXPDP
cd /Migracion3/TRZS/EXP_FULL_TRZS

while true; do egrep -i BALANCEHIST_20 EXPDP_FULL_TRZS_1.LOG |wc -l; sleep 30; clear; done

while true; do egrep -i "TRAN\":\"TRAN_2024_" EXPDP_FULL_TRZS_1.LOG; sleep 30; clear; done

while true; do egrep -i DOER_2024_ EXPDP_FULL_TRZS_1.LOG; sleep 30; clear; done





***************************************************************************************************************
***************************************************************************************************************


*servidor 172.27.70.66   =========IMPORT===========

--*Import Metadata
--cd /Migracion3/TRZS/scripts/Import
--
--nohup ./03_imports_trzsp.sh &
--
--impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

*Modificar ARCHIVOS INDEX --Mientras corre el import de la data (50 min aprox)
--time ./04_prepare_ddl_index.sh


--*Deshabilitar y crear triggers
--cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

-->SQL
--sqlplus / as sysdba @05_disable_trigger.sql
--@06_create_dml_parallel_trigger.sql


--*Import Data
--cd /Migracion3/TRZS/scripts/Import

--nohup ./07_imports_data_trzsp.sh &

--impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01

--while true; do egrep -i BALANCEHIST IMP_DATA_TRZS_1.LOG | wc -l; sleep 30; clear; done

--while true; do egrep -i "TRAN\":\"TRAN_2024_" IMP_DATA_TRZS_1.LOG; sleep 30; clear; done

--while true; do egrep -i DOER_2024_ IMP_DATA_TRZS_1.LOG; sleep 30; clear; done

--egrep -i BALANCEHIST IMP_DATA_TRZS_1.LOG



--cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG
--
--*Habilita trigger
-->SQL
--
--@08_enable_trigger.sql
--
--
--/bash
--
--
nohup ./12_ddl_index_lotes.sh &

while true
do
ps -ef | grep -i "ddl_index" | grep -v grep
echo "--------------------------------"
date
sleep 5
done

*****

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG/IDX_LOG

--while true; do  egrep -inw error ddl_index_trzsp_full_*.log; sleep 60; clear; done

--while true; do  egrep -A2 -inw error ddl_index_trzsp_full_*.log |egrep -v "ORA-00054" |egrep -v "ERROR at line 1" ; sleep 60; clear; done

while true; do  egrep -A2 -inw error ddl_index_trzsp_full_*.log ; sleep 60; clear; done

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG
sqlplus / as sysdba  @ddl_index_trzsp_full_34.sql
@ddl_index_trzsp_full_47.sql

*****

cd /Migracion3/TRZS/scripts
sqlplus / as sysdba @26_comparar_objetos.sql


nohup ./13_ddl_constraints_lotes.sh &

while true
do
ps -ef | grep -i "ddl_const" | grep -v grep
date
echo "-----------------------------"
sleep 5
done

nohup ./14_ddl_constraints_lotes.sh &

>SQL
sqlplus / as sysdba @15_homologacion_degree_parallel.sql

cd /Migracion3/TRZS/scripts
sqlplus / as sysdba @26_comparar_objetos.sql


cd /Migracion3/TRZS/scripts/OBJETOS_INVALIDOS

>SQL   

sqlplus / as sysdba @16_create_procedure_kill_database_session.sql

@17_homologacion_permisologia.sql

@18_exec_homologacion_permisologia.sql

@19_verificar_objetos_invalidos.sql

@20_compilar_objetos_invalidos.sql

@21_verificar_objetos_invalidos.sql

@22_dba_registry.sql


cd /Migracion3/TRZS/scripts

>SQL

sqlplus / as sysdba @23_validar_usuarios.sql

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
alter system set cluster_database=TRUE scope=spfile;


alter system set aq_tm_processes=1;
alter system set streams_pool_size=10G;
alter system set db_block_checking=MEDIUM;
alter system set db_block_checksum=TYPICAL;
alter system reset "_dlm_stats_collect" SCOPE=SPFILE;

alter database force logging;


alter system switch logfile;
alter system switch logfile;
alter system checkpoint;

--ARCHIVELOG
archive log list;

shutdown immediate;

startup mount;

alter database archivelog;

alter database open;

archive log list;

--FLASHBACK
ALTER DATABASE FLASHBACK ON;



/



srvctl status database -d TRZSP
srvctl stop database -d TRZSP
srvctl start database -d TRZSP
srvctl status database -d TRZSP



>SQL

sqlplus / as sysdba @27_estadisticas.sql

********
70.66

--alter system set session_cached_cursors=8192 scope=spfile;
--alter system set cursor_sharing=FORCE;









cd /Migracion3/TRZS 
tar -cvzf respaldo_script_migracion_tx_20241010.tar.gz scripts/



egrep -in error ddl_index_trzsp_full_*.log