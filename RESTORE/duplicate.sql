*.audit_file_dest='/oracle/app/oracle12/admin/PAGOFP/adump'
*.audit_trail='db'
*.compatible='12.2.0'
*.control_files='+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195386217','+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195386239'
*.cursor_sharing='FORCE'
*.db_block_size=8192
PAGOFP.db_cache_advice='ON'
*.db_create_file_dest='+DG_DATA_PAGOFP'
*.db_create_online_log_dest_1='+DG_REDO01_PAGOFP'
*.db_create_online_log_dest_2='+DG_REDO02_PAGOFP'
*.db_files=1024
*.db_name='PAGOFP'
*.db_recovery_file_dest='+FRA'
*.db_recovery_file_dest_size=322122547200
*.diagnostic_dest='/oracle/app/oracle12'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=PAGOFPXDB)'
*.enable_ddl_logging=TRUE
###*.local_listener='LISTENER_PAGOFP'
*.log_archive_dest_1='LOCATION=+FRA'
*.log_archive_format='%t_%s_%r.dbf'
*.log_archive_max_processes=30
*.nls_language='AMERICAN'
*.nls_territory='AMERICA'
*.open_cursors=500
*.parallel_degree_policy='AUTO'
*.parallel_min_time_threshold='5'
*.pga_aggregate_limit=0
*.pga_aggregate_target=53687091200
*.processes=10000
*.remote_login_passwordfile='EXCLUSIVE'
*.session_cached_cursors=1200
*.sessions=3147
*.sga_max_size=40687091200
*.sga_target=10687091200
*.statistics_level='ALL'
PAGOFP.timed_os_statistics=60
PAGOFP.timed_statistics=TRUE
*.transactions=3169
*.undo_tablespace='UNDOTBS1'

+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195386217
+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195386239




rman target / catalog rman/rmanexport@RMAN

rman target / catalog rmanp/rmanexport@RMAN12

list backup of database completed between "to_date('01/10/2024','DD/MM/YYYY')" and "to_date('30/10/2024','DD/MM/YYYY')";

list backup of database completed between "to_date('08/01/2020','DD/MM/YYYY')" and "to_date('10/01/2020','DD/MM/YYYY')";

list backup of database completed between "to_date('14/01/2020','DD/MM/YYYY')" and "to_date('16/01/2020','DD/MM/YYYY')";


export ORACLE_SID=PAGOFP

STARTUP NOMOUNT PFILE='/export/home/oracle12/scripts/copia_pfile/pfilePAGOFP.ora';

CREATE DATABASE PAGOFP
USER SYS IDENTIFIED BY password
USER SYSTEM IDENTIFIED BY password
LOGFILE GROUP 1 ('/path/to/redo01.log') SIZE 100M,
        GROUP 2 ('/path/to/redo02.log') SIZE 100M
MAXLOGFILES 5
MAXLOGFILESIZE 100M
MAXDATAFILES 100
CHARACTER SET UTF8
NATIONAL CHARACTER SET AL16UTF16
;

@?/rdbms/admin/catalog.sql 
@?/rdbms/admin/catproc.sql
@?/sqlplus/admin/pupbld.sql

SHUTDOWN IMMEDIATE;
STARTUP;


create pfile='/export/home/oracle12/scripts/copia_pfile/pfilePAGOFP.ora' from spfile;

***Modificar el archivo cambiar todo de YEIMARU a PAGOFP

oracle19@sun2236c:~/duplicate_yb$ cat pfileYEIMARU.ora
*._cursor_obsolete_threshold=1024
*.audit_file_dest='/oracle/app/oracle/admin/yeimaru/adump'
*.audit_trail='db'
*.compatible='19.0.0'
*.db_block_checking='MEDIUM'
*.db_block_checksum='FULL'
*.db_block_size=8192
*.db_create_file_dest='+DG_DATA_PAGOFP'
*.db_files=1024
*.db_flashback_retention_target=4320
*.db_lost_write_protect='TYPICAL'
*.db_name='YEIMARU'
*.db_recovery_file_dest='+FRA'
*.db_recovery_file_dest_size=90g
*.diagnostic_dest='/oracle/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=YEIMARUXDB)'
*.fast_start_mttr_target=300
*.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=sun2236c.banvenqa.com)(PORT=1522))'
*.log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=ENTITID ALTERNATE=LOG_ARCHIVE_DEST_10'
*.log_archive_dest_10='location=+DATA valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=ENTITID ALTERNATE=LOG_ARCHIVE_DEST_1'
*.log_archive_dest_state_1='ENABLE'
*.log_archive_dest_state_10='ALTERNATE'
*.log_archive_format='%t_%s_%r.dbf'
*.nls_language='AMERICAN'
*.nls_territory='AMERICA'
*.open_cursors=2048
*.pga_aggregate_target=1024m
*.processes=4096
*.remote_login_passwordfile='EXCLUSIVE'
*.session_cached_cursors=600
*.sga_target=2048m
*.undo_tablespace='UNDOTBS1'
oracle19@sun2236c:~/duplicate_yb$

************************************************************************************************************

**Crear carpeta del adump, auditoria

mkdir -p /oracle/app/oracle12/admin/PAGOFP/adump

************************************************************************************************************



run
{
        allocate auxiliary channel t1 type 'SBT_TAPE' parms 'ENV=(NSR_DATA_VOLUME_POOL=PAGOFP_BOVEDA_MENSUAL,NSR_CLIENT=sun1330p,NSR_SERVER=cpprwnetworkerp)';
        duplicate database PAGOFP dbid 4272745383 to PAGOFP nofilenamecheck
        until scn =25565245892;
        release channel t1;
        release channel t2;
        release channel t3;
        release channel t4;
}

rman target / catalog rmanp/rmanexport@RMAN12
list backup of database completed between "to_date('01/10/2024','DD/MM/YYYY')" and "to_date('30/11/2024','DD/MM/YYYY')";


SELECT COUNT (1) FROM V$DATAFILE; 

c-4272745383-20240803-00
cu31gpt0_1_1
cv31h16v_1_1
ct31gnn3_1_1
cs31gfm9_1_1
cr31gfm8_1_1

startup mount pfile='/oracle/app/oracle12/product/12.2.0/db_1/dbs/initPAGOFP.ora';
+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195386217
+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195386239




DATA_AUDITORIA.288.1195446801
DATA_ORDENES_PC.256.1195415849
DATA_ORDENES_PC.287.1195445477
DATA_USER_PC.268.1195423681
DATA_USER_PC.274.1195430089
INDX_ORDENES_PC.279.1195439069
INDX_USER_PC.267.1195423681
SYSAUX.258.1195412923
SYSAUX.259.1195412923
SYSAUX.264.1195412923
SYSAUX.266.1195420701
SYSAUX.272.1195426899
SYSAUX.273.1195428503
SYSAUX.276.1195431469
SYSAUX.278.1195436095
SYSAUX.282.1195439227
SYSAUX.284.1195442299
SYSAUX.285.1195443903
SYSAUX.286.1195443903
SYSTEM.275.1195431429
SYSTEM.281.1195439069
UNDOTBS1.257.1195415849
UNDOTBS1.260.1195412921
UNDOTBS1.261.1195420701
UNDOTBS1.263.1195416083
UNDOTBS1.265.1195408275
UNDOTBS1.269.1195423783
UNDOTBS1.270.1195425373
UNDOTBS1.271.1195426899
UNDOTBS1.277.1195436095
UNDOTBS1.280.1195439069
UNDOTBS1.283.1195439227
USERS.262.1195415849



+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482665
+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482685


*.control_files='+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482665','+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482685'
