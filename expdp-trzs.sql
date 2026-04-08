+----------------------------+
| Scripts prueba expdp/impdp |
+----------------------------+

********************************************
********************************************
********************************************
	* REVISAR_Y_CREAR_DIRECTORIOS
	* MODIFICAR_VERIFICAR_PARALELISMO
	* EXPDP_FULL_TRZSP_3
	* EXPDP_FULL_TRZSP_v4
	* EXPDP_TABLE_POSTING_BK
	* MONITOREO_TABLAS_LOG
	* MONITOREO_SO
*********************************************
*********************************************
*********************************************

sed -i 's/\r//g' 03_ddl_index_lotes.sh


* REVISAR_Y_CREAR_DIRECTORIOS
Crear directory
df -k

sql

SET LINE 400
COL OWNER FORMAT A25
COL DIRECTORY_NAME FORMAT A30
COL DIRECTORY_PATH FORMAT A100
SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
/


DROP DIRECTORY MIGRACION_FULL;

CREATE DIRECTORY MIGRACION_FULL AS '/Migracion3/TRZS';
GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL TO SYSTEM;
/exportdb/TRZS

DIRECTORIES_
OWNER  DIRECTORY_PATH      DIRECTORY_NAME
------ ------------------- ------------------------------
SYS    /Migracion3/TRZS    MIGRACION_FULL



*********************
/Migracion3/TRZS/scripts

***********
--Parfile expdp
--
--vi parfile_expdp_full_TRZS_2.par
--DIRECTORY=MIGRACION_FULL
--FULL=Y
--LOGFILE=EXPDP_FULL_TRZS_5.LOG
--DUMPFILE=EXP_FULL_TRZS_%T_%L.dmp
--LOGTIME=ALL
--METRICS=Y
--PARALLEL=64
--CLUSTER=N
--EXCLUDE=AUDIT_TRAILS
--EXCLUDE=STATISTICS
--EXCLUDE=TABLE:"IN('POSTING')"
--EXCLUDE=TABLE:"IN('DOEREXTMSG')"

--EXCLUDE=TABLE_DATA:"IN('DOEREXTMSG_2024_08_23')"


--nohup expdp system/bdv23ccs2 parfile=parfile_expdp_full_TRZS_2.par &


--expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01




* EXPDP_FULL_TRZSP_3
*********************
--30082024
--****
--vi parfile_expdp_full_TRZS_3.par
--DIRECTORY=MIGRACION_FULL
--FULL=Y
--LOGFILE=EXPDP_FULL_TRZS_6.LOG
--DUMPFILE=EXP_FULL_TRZS_%T_%L.dmp
--LOGTIME=ALL
--METRICS=Y
--PARALLEL=58
--CLUSTER=N
--EXCLUDE=AUDIT_TRAILS
--EXCLUDE=STATISTICS
--EXCLUDE=TABLE:"IN('POSTING_BK')"
--
--
--nohup expdp system/bdv23ccs2 parfile=parfile_expdp_full_TRZS_3.par &
--
--expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01




* EXPDP_FULL_TRZSP_v4
*********************
20240911
****

vi parfile_expdp_full_TRZS_v4.par
DIRECTORY=MIGRACION_FULL
FULL=Y
LOGFILE=EXPDP_FULL_TRZS_v4_1.LOG
DUMPFILE=EXP_FULL_TRZS_%T_%L.dmp
LOGTIME=ALL
METRICS=Y
PARALLEL=58
CLUSTER=N
EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS

nohup expdp system/bdv23ccs2 parfile=parfile_expdp_full_TRZS_v4.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01



TRACE=1ff0300


EXCLUDE=TABLE:"IN('DOEREXTMSG')"


************************
--* MODIFICAR_VERIFICAR_PARALELISMO
--
--
--ALTER TABLE TX.POSTING_BK PARALLEL 16;
--
--ALTER TABLE TX.DOEREXTMSG PARALLEL 4;
--
--Verificar
--
--select TABLE_NAME, DEGREE from dba_tables where TABLE_NAME = 'DOEREXTMSG';


************************
parfile tabla DOEREXTMSG
--
--vi parfile_expdp_table_doerextmsg.par
--
--DIRECTORY=MIGRACION_FULL
--DUMPFILE=EXP_DOEREXTMSG_TRZS_%T_%L.dmp
--LOGFILE=EXPDP_DOEREXTMSG_TRZS_1.LOG
--TABLES=TX.DOEREXTMSG
--PARALLEL=52
--LOGTIME=ALL
--METRICS=Y
--CLUSTER=N
--EXCLUDE=STATISTICS
--
--
nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_doerextmsg.par &
--
expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01


nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_doerextmsg_with_trace.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01

******

--parfile tabla POSTING
--
--vi parfile_expdp_table_posting.par
--
--DIRECTORY=MIGRACION_FULL
--DUMPFILE=EXP_POSTING_TRZS_%T_%L.dmp
--LOGFILE=EXPDP_POSTING_TRZS_1.LOG
--TABLES=TX.POSTING
--PARALLEL=52
--LOGTIME=ALL
--METRICS=Y
--CLUSTER=N
--EXCLUDE=STATISTICS
--
--nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_posting.par &
--
--expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01



* EXPDP_TABLE_POSTING_BK
--******
--
--ALTER TABLE TX.POSTING_BK PARALLEL 16;
--
--
--parfile tabla POSTING_BK
--
--vi parfile_expdp_table_posting_BK.par
--
--DIRECTORY=MIGRACION_TABLAS
--DUMPFILE=EXP_POSTING_BK_TRZS_%T_%L.dmp
--LOGFILE=EXPDP_POSTING_BK_TRZS_1.LOG
--TABLES=TX.POSTING_BK
--PARALLEL=52
--LOGTIME=ALL
--METRICS=Y
--CLUSTER=N
--EXCLUDE=STATISTICS
--
--nohup expdp system/bdv23ccs2 parfile=parfile_expdp_table_posting_BK.par &
--
--expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_02
--
**********************

* MONITOREO_TABLAS_LOG

 while true; do egrep -i POSTING EXPDP_FULL_TRZS_v4_1.LOG; sleep 60; clear; done
 while true; do egrep -i TRAN_2024_ EXPDP_FULL_TRZS_v4_34.LOG; sleep 60; clear; done
 while true; do egrep -i DOER_2024 EXPDP_FULL_TRZS_v4_34.LOG; sleep 60; clear; done
 while true; do egrep -i BATCH EXPDP_FULL_TRZS_v4_34.LOG; sleep 60; clear; done



 while true; do egrep -i TRAN_2024_ IMP_DATA_TRZS_3.LOG; sleep 60; clear; done
 while true; do egrep -i DOER_2024 IMP_DATA_TRZS_3.LOG; sleep 60; clear; done
 while true; do egrep -i BALANCEHIST_20 IMP_DATA_TRZS_3.LOG | wc -l; sleep 60; clear; done


 IMP_DATA_TRZS_3.LOG

 cat EXPDP_FULL_TRZS_v4.LOG | awk '{ print $7 " -- " $13 }' | sort -n -k3




**********
* MONITOREO_SO
--iostat -xntz | sort -nk8 | tail -10

vmstat 5 1000000
 
while true; do iostat -d -x 2 2 | sort -n -k 11; sleep 5; echo ------- ; done


iostat -d -x 2 2 | sort -n -k 11 | more

**********
Verificar paralelismo en un a tabla

select TABLE_NAME, DEGREE from dba_tables where TABLE_NAME = 'POSTING';



****
select /*+ full(x) parallel(x 64) */
count(1) 
from TX.DOEREXTMSG partition(DOEREXTMSG_2024_09_11) x ;

