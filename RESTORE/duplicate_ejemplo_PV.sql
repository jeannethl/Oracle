************Ejecucion de DUPLICATE en CALIDA************

*****Crear el pfile, con los nombre de la instancia que va crear

create pfile='/export/home/oracle19/duplicate/pfilePAGOFP.ora' from spfile;

*********************************************************************************************

***Modificar el archivo cambiar todo de ENTITID a PAGOFP

oracle19@sun2236c:~/duplicate_yb$ cat pfilePAGOFP.ora
*._cursor_obsolete_threshold=1024
*.audit_file_dest='/oracle/app/oracle/admin/PAGOFP/adump'
*.audit_trail='db'
*.compatible='19.0.0'
*.db_block_checking='MEDIUM'
*.db_block_checksum='FULL'
*.db_block_size=8192
*.db_create_file_dest='+DATA'
*.db_files=1024
*.db_flashback_retention_target=4320
*.db_lost_write_protect='TYPICAL'
*.db_name='PAGOFP'
*.db_recovery_file_dest='+FRA'
*.db_recovery_file_dest_size=90g
*.diagnostic_dest='/oracle/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=PAGOFPXDB)'
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

mkdir -p /oracle/app/oracle/admin/PAGOFP/adump

************************************************************************************************************

***Colocar la BD STARTED o NOMOUNT  

export ORACLE_SID=PAGOFP

SQL> startup nomount pfile='/oracle/app/oracle12/product/12.2.0/db_1/dbs/initPAGOFP.ora';
ORACLE instance started.

Total System Global Area 2147478480 bytes
Fixed Size                  8874960 bytes
Variable Size             855638016 bytes
Database Buffers         1275068416 bytes
Redo Buffers                7897088 bytes

Verificar con pmon

oracle19@sun2236c:~/duplicate_yb$ ps -ef|grep -i pmon
    grid  1923     1   0   Jun 02 ?          84:43 asm_pmon_+ASM
oracle19 27323 26314   0 14:52:50 pts/1       0:00 grep -i pmon
oracle19 21542     1   0   Jun 03 ?         327:30 ora_pmon_ENTITID
oracle19 29315     1   0   Jul 27 ?         128:04 ora_pmon_ENTITIDP1
oracle19 23298     1   0 14:45:50 ?           0:00 ora_pmon_PAGOFP



**crear el spfile del pfile

create spfile='+DATA' from pfile='/oracle/app/oracle19/product/19c/db1/dbs/initINTRNETD.ora';

shutdown immediate;

SQL> startup nomount;
ORA-01078: failure in processing system parameters
LRM-00109: could not open parameter file '/oracle/app/oracle/product/19c/db1/dbs/initPAGOFP.ora'


dentro del init agregar el spfile dentro del init

'+DATA/PAGOFP/PARAMETERFILE/spfile.302.1158678869'


en la ruta $ORACLE_HOME/dbs

vi pfilePAGOFP.ora
spfile='+DATA/PAGOFP/PARAMETERFILE/spfile.302.1158678869'

bajar y subir BD


************************************************************************************************************

*****Correr el SCRIPTS de DUPLICATE**************************************


******Para crear el duplicate se necesita el current scn y dbid

SELECT CURRENT_SCN FROM V$DATABASE;

118770049
118772596
118775222

***buscar el scn de una hora en especifica

select timestamp_to_scn(to_timestamp('01-10-2024 15:25:05','DD-MM-YYYY HH24:MI:SS')) "SCN" from dual;

select timestamp_to_scn(to_timestamp('sysdate-150')) "SCN" from dual;


select dbid from v$database;

4272745383
--26475277055

rman target en BD origen 
list backup summary;

vi duplicate_PAGOFP.cmd

run
{
        allocate auxiliary channel t1 type 'SBT_TAPE' parms 'ENV=(NSR_DATA_VOLUME_POOL=PAGOFP_BOVEDA_MENSUAL,NSR_CLIENT=sun1330p,NSR_SERVER=cpprwnetworkerp)';
        duplicate database PAGOFP dbid 4272745383 to PAGOFP nofilenamecheck
        until scn =26475277055;
        release channel t1;
        release channel t2;
        release channel t3;
        release channel t4;
}


nohup rman target sys/k3r3p4kup41@PAGOFP auxiliary / cmdfile=duplicate_PAGOFP.cmd log=duplicate_PAGOFP.log &

******************************************************************************************************************

Salida del DUPLICATE

oracle19@sun2236c:~/duplicate_yb$ tail -100f duplicate_PAGOFP.log

Recovery Manager: Release 19.0.0.0.0 - Production on Fri Jan 19 16:09:51 2024
Version 19.13.0.0.0

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

connected to target database: ENTITID (DBID=1180704181)
connected to auxiliary database: PAGOFP (not mounted)

RMAN> run
2> {
3>      allocate auxiliary channel t1 type 'SBT_TAPE' parms 'ENV=(NSR_DATA_VOLUME_POOL=ENTITID_ONL_SEMANAL,NSR_CLIENT=sun2236c,NSR_SERVER=cpprwnetworkerp)';
4>      duplicate database ENTITID dbid 1180704181 to PAGOFP nofilenamecheck
5>      until scn =118501264;
6>      release channel t1;
7> }
8>
9>
using target database control file instead of recovery catalog
allocated channel: t1
channel t1: SID=774 device type=SBT_TAPE
channel t1: NMDA Oracle v19.2.1.3

Starting Duplicate Db at 19-JAN-24
duplicating Online logs to Oracle Managed File (OMF) location
duplicating Datafiles to Oracle Managed File (OMF) location

contents of Memory Script:
{
   set until scn  118501264;
   sql clone "alter system set  control_files =
  ''+DATA/PAGOFP/CONTROLFILE/current.305.1158682197'', ''+FRA/PAGOFP/CONTROLFILE/current.353.1158682197'' comment=
 ''Set by RMAN'' scope=spfile";
   sql clone "alter system set  db_name =
 ''ENTITID'' comment=
 ''Modified by RMAN duplicate'' scope=spfile";
   sql clone "alter system set  db_unique_name =
 ''PAGOFP'' comment=
 ''Modified by RMAN duplicate'' scope=spfile";
   shutdown clone immediate;
   startup clone force nomount
   restore clone primary controlfile;
   alter clone database mount;
}
executing Memory Script

executing command: SET until clause

sql statement: alter system set  control_files =   ''+DATA/PAGOFP/CONTROLFILE/current.305.1158682197'', ''+FRA/PAGOFP/CONTROLFILE/current.353.1158682197'' comment= ''Set by RMAN'' scope=spfile

sql statement: alter system set  db_name =  ''ENTITID'' comment= ''Modified by RMAN duplicate'' scope=spfile

sql statement: alter system set  db_unique_name =  ''PAGOFP'' comment= ''Modified by RMAN duplicate'' scope=spfile

Oracle instance shut down

Oracle instance started

Total System Global Area    2147478480 bytes

Fixed Size                     8874960 bytes
Variable Size                855638016 bytes
Database Buffers            1275068416 bytes
Redo Buffers                   7897088 bytes
allocated channel: t1
channel t1: SID=777 device type=SBT_TAPE
channel t1: NMDA Oracle v19.2.1.3

Starting restore at 19-JAN-24

channel t1: starting datafile backup set restore
channel t1: restoring control file
channel t1: reading from backup piece c-1180704181-20240113-00
channel t1: piece handle=c-1180704181-20240113-00 tag=TAG20240113T210807
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:09
output file name=+DATA/PAGOFP/CONTROLFILE/current.305.1158682197
output file name=+FRA/PAGOFP/CONTROLFILE/current.353.1158682197
Finished restore at 19-JAN-24

database mounted

contents of Memory Script:
{
   set until scn  118501264;
   sql clone 'alter database flashback off';
   set newname for clone datafile  1 to new;
   set newname for clone datafile  2 to new;
   set newname for clone datafile  3 to new;
   set newname for clone datafile  4 to new;
   set newname for clone datafile  5 to new;
   set newname for clone datafile  7 to new;
   set newname for clone datafile  8 to new;
   set newname for clone datafile  9 to new;
   set newname for clone datafile  10 to new;
   set newname for clone datafile  11 to new;
   set newname for clone datafile  12 to new;
   set newname for clone datafile  13 to new;
   restore
   clone database
   ;
}
executing Memory Script

executing command: SET until clause

sql statement: alter database flashback off

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

Starting restore at 19-JAN-24

channel t1: starting datafile backup set restore
channel t1: specifying datafile(s) to restore from backup set
channel t1: restoring datafile 00001 to +DATA
channel t1: restoring datafile 00009 to +DATA
channel t1: restoring datafile 00012 to +DATA
channel t1: reading from backup piece 502ggsk2_6304_1_1
channel t1: piece handle=502ggsk2_6304_1_1 tag=ENTITID_ONL_SEMANAL
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:45
channel t1: starting datafile backup set restore
channel t1: specifying datafile(s) to restore from backup set
channel t1: restoring datafile 00003 to +DATA
channel t1: restoring datafile 00007 to +DATA
channel t1: restoring datafile 00011 to +DATA
channel t1: reading from backup piece 522ggsk2_6306_1_1
channel t1: piece handle=522ggsk2_6306_1_1 tag=ENTITID_ONL_SEMANAL
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:35
channel t1: starting datafile backup set restore
channel t1: specifying datafile(s) to restore from backup set
channel t1: restoring datafile 00002 to +DATA
channel t1: restoring datafile 00008 to +DATA
channel t1: restoring datafile 00010 to +DATA
channel t1: reading from backup piece 512ggsk2_6305_1_1
channel t1: piece handle=512ggsk2_6305_1_1 tag=ENTITID_ONL_SEMANAL
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:25
channel t1: starting datafile backup set restore
channel t1: specifying datafile(s) to restore from backup set
channel t1: restoring datafile 00004 to +DATA
channel t1: restoring datafile 00005 to +DATA
channel t1: restoring datafile 00013 to +DATA
channel t1: reading from backup piece 4v2ggsk1_6303_1_1
channel t1: piece handle=4v2ggsk1_6303_1_1 tag=ENTITID_ONL_SEMANAL
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:55
Finished restore at 19-JAN-24

contents of Memory Script:
{
   switch clone datafile all;
}
executing Memory Script

datafile 1 switched to datafile copy
input datafile copy RECID=21 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/system.307.1158682259
datafile 2 switched to datafile copy
input datafile copy RECID=22 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/spiderbase.313.1158682339
datafile 3 switched to datafile copy
input datafile copy RECID=23 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/sysaux.309.1158682305
datafile 4 switched to datafile copy
input datafile copy RECID=24 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/undotbs1.315.1158682365
datafile 5 switched to datafile copy
input datafile copy RECID=25 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/bmibase.316.1158682365
datafile 7 switched to datafile copy
input datafile copy RECID=26 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/users.311.1158682305
datafile 8 switched to datafile copy
input datafile copy RECID=27 STAMP=1158682418 file name=+DATA/PAGOFP/DATAFILE/e2fdatosbase.312.1158682339
datafile 9 switched to datafile copy
input datafile copy RECID=28 STAMP=1158682419 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.306.1158682259
datafile 10 switched to datafile copy
input datafile copy RECID=29 STAMP=1158682419 file name=+DATA/PAGOFP/DATAFILE/undotbs1.314.1158682341
datafile 11 switched to datafile copy
input datafile copy RECID=30 STAMP=1158682419 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.310.1158682305
datafile 12 switched to datafile copy
input datafile copy RECID=31 STAMP=1158682419 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.308.1158682259
datafile 13 switched to datafile copy
input datafile copy RECID=32 STAMP=1158682419 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.317.1158682365

contents of Memory Script:
{
   set until scn  118501264;
   recover
   clone database
    delete archivelog
   ;
}
executing Memory Script

executing command: SET until clause

Starting recover at 19-JAN-24

starting media recovery

channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4651
channel t1: reading from backup piece al_6313_1_1158181643
channel t1: piece handle=al_6313_1_1158181643 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4651.382.1158682427 thread=1 sequence=4651
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4651.382.1158682427 RECID=4644 STAMP=1158682427
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4652
channel t1: reading from backup piece al_6316_1_1158181651
channel t1: piece handle=al_6316_1_1158181651 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4652.382.1158682431 thread=1 sequence=4652
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4652.382.1158682431 RECID=4645 STAMP=1158682430
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4653
channel t1: reading from backup piece 5f2ggsp9_6319_1_1
channel t1: piece handle=5f2ggsp9_6319_1_1 tag=ENTITID_ARCH_SEM
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4653.382.1158682435 thread=1 sequence=4653
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4653.382.1158682435 RECID=4646 STAMP=1158682434
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4654
channel t1: reading from backup piece 5g2ggsp9_6320_1_1
channel t1: piece handle=5g2ggsp9_6320_1_1 tag=ENTITID_ARCH_SEM
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4654.382.1158682437 thread=1 sequence=4654
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4654.382.1158682437 RECID=4647 STAMP=1158682437
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4655
channel t1: reading from backup piece al_6324_1_1158196154
channel t1: piece handle=al_6324_1_1158196154 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4655.382.1158682441 thread=1 sequence=4655
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4655.382.1158682441 RECID=4648 STAMP=1158682442
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4656
channel t1: reading from backup piece al_6325_1_1158210375
channel t1: piece handle=al_6325_1_1158210375 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4656.382.1158682455 thread=1 sequence=4656
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4656.382.1158682455 RECID=4649 STAMP=1158682455
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4657
channel t1: reading from backup piece al_6326_1_1158224751
channel t1: piece handle=al_6326_1_1158224751 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4657.382.1158682459 thread=1 sequence=4657
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4657.382.1158682459 RECID=4650 STAMP=1158682460
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4658
channel t1: reading from backup piece al_6327_1_1158239169
channel t1: piece handle=al_6327_1_1158239169 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4658.382.1158682469 thread=1 sequence=4658
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4658.382.1158682469 RECID=4651 STAMP=1158682470
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4659
channel t1: reading from backup piece al_6328_1_1158253549
channel t1: piece handle=al_6328_1_1158253549 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4659.382.1158682479 thread=1 sequence=4659
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4659.382.1158682479 RECID=4652 STAMP=1158682479
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4660
channel t1: reading from backup piece al_6329_1_1158267980
channel t1: piece handle=al_6329_1_1158267980 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4660.382.1158682489 thread=1 sequence=4660
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4660.382.1158682489 RECID=4653 STAMP=1158682490
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4661
channel t1: reading from backup piece al_6330_1_1158282377
channel t1: piece handle=al_6330_1_1158282377 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4661.382.1158682501 thread=1 sequence=4661
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4661.382.1158682501 RECID=4654 STAMP=1158682502
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4662
channel t1: reading from backup piece al_6331_1_1158296776
channel t1: piece handle=al_6331_1_1158296776 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4662.382.1158682513 thread=1 sequence=4662
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4662.382.1158682513 RECID=4655 STAMP=1158682514
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4663
channel t1: reading from backup piece al_6332_1_1158311161
channel t1: piece handle=al_6332_1_1158311161 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4663.382.1158682519 thread=1 sequence=4663
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4663.382.1158682519 RECID=4656 STAMP=1158682518
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4664
channel t1: reading from backup piece al_6333_1_1158325548
channel t1: piece handle=al_6333_1_1158325548 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4664.382.1158682523 thread=1 sequence=4664
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4664.382.1158682523 RECID=4657 STAMP=1158682523
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4665
channel t1: reading from backup piece al_6334_1_1158339955
channel t1: piece handle=al_6334_1_1158339955 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4665.382.1158682527 thread=1 sequence=4665
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4665.382.1158682527 RECID=4658 STAMP=1158682527
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4666
channel t1: reading from backup piece al_6335_1_1158354376
channel t1: piece handle=al_6335_1_1158354376 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4666.382.1158682531 thread=1 sequence=4666
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4666.382.1158682531 RECID=4659 STAMP=1158682532
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4667
channel t1: reading from backup piece al_6336_1_1158368765
channel t1: piece handle=al_6336_1_1158368765 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4667.382.1158682541 thread=1 sequence=4667
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4667.382.1158682541 RECID=4660 STAMP=1158682542
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4668
channel t1: reading from backup piece al_6337_1_1158383155
channel t1: piece handle=al_6337_1_1158383155 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4668.382.1158682553 thread=1 sequence=4668
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4668.382.1158682553 RECID=4661 STAMP=1158682553
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4669
channel t1: reading from backup piece al_6338_1_1158397580
channel t1: piece handle=al_6338_1_1158397580 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4669.382.1158682557 thread=1 sequence=4669
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4669.382.1158682557 RECID=4662 STAMP=1158682558
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4670
channel t1: reading from backup piece al_6339_1_1158411966
channel t1: piece handle=al_6339_1_1158411966 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4670.382.1158682561 thread=1 sequence=4670
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4670.382.1158682561 RECID=4663 STAMP=1158682562
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4671
channel t1: reading from backup piece al_6340_1_1158426381
channel t1: piece handle=al_6340_1_1158426381 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4671.382.1158682571 thread=1 sequence=4671
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4671.382.1158682571 RECID=4664 STAMP=1158682571
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4672
channel t1: reading from backup piece al_6341_1_1158440761
channel t1: piece handle=al_6341_1_1158440761 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4672.382.1158682575 thread=1 sequence=4672
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4672.382.1158682575 RECID=4665 STAMP=1158682576
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4673
channel t1: reading from backup piece al_6342_1_1158455305
channel t1: piece handle=al_6342_1_1158455305 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4673.382.1158682581 thread=1 sequence=4673
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4673.382.1158682581 RECID=4666 STAMP=1158682581
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4674
channel t1: reading from backup piece al_6343_1_1158469556
channel t1: piece handle=al_6343_1_1158469556 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4674.382.1158682593 thread=1 sequence=4674
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4674.382.1158682593 RECID=4667 STAMP=1158682592
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4675
channel t1: reading from backup piece al_6344_1_1158483962
channel t1: piece handle=al_6344_1_1158483962 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4675.382.1158682599 thread=1 sequence=4675
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4675.382.1158682599 RECID=4668 STAMP=1158682598
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4676
channel t1: reading from backup piece al_6345_1_1158498358
channel t1: piece handle=al_6345_1_1158498358 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4676.382.1158682605 thread=1 sequence=4676
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4676.382.1158682605 RECID=4669 STAMP=1158682605
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4677
channel t1: reading from backup piece al_6346_1_1158512759
channel t1: piece handle=al_6346_1_1158512759 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4677.382.1158682611 thread=1 sequence=4677
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4677.382.1158682611 RECID=4670 STAMP=1158682610
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4678
channel t1: reading from backup piece al_6347_1_1158527193
channel t1: piece handle=al_6347_1_1158527193 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4678.382.1158682615 thread=1 sequence=4678
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4678.382.1158682615 RECID=4671 STAMP=1158682615
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4679
channel t1: reading from backup piece al_6348_1_1158541570
channel t1: piece handle=al_6348_1_1158541570 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4679.382.1158682619 thread=1 sequence=4679
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4679.382.1158682619 RECID=4672 STAMP=1158682620
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4680
channel t1: reading from backup piece al_6349_1_1158555959
channel t1: piece handle=al_6349_1_1158555959 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4680.382.1158682633 thread=1 sequence=4680
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4680.382.1158682633 RECID=4673 STAMP=1158682633
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4681
channel t1: reading from backup piece al_6350_1_1158570363
channel t1: piece handle=al_6350_1_1158570363 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4681.382.1158682637 thread=1 sequence=4681
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4681.382.1158682637 RECID=4674 STAMP=1158682637
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4682
channel t1: reading from backup piece al_6351_1_1158584759
channel t1: piece handle=al_6351_1_1158584759 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4682.382.1158682641 thread=1 sequence=4682
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4682.382.1158682641 RECID=4675 STAMP=1158682641
channel t1: starting archived log restore to default destination
channel t1: restoring archived log
archived log thread=1 sequence=4683
channel t1: reading from backup piece al_6352_1_1158599160
channel t1: piece handle=al_6352_1_1158599160 tag=ENTITID_ARCHIVES
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:03
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4683.382.1158682645 thread=1 sequence=4683
channel clone_default: deleting archived log(s)
archived log file name=+FRA/PAGOFP/ARCHIVELOG/2024_01_19/thread_1_seq_4683.382.1158682645 RECID=4676 STAMP=1158682646
media recovery complete, elapsed time: 00:00:01
Finished recover at 19-JAN-24
released channel: t1
Oracle instance started

Total System Global Area    2147478480 bytes

Fixed Size                     8874960 bytes
Variable Size                855638016 bytes
Database Buffers            1275068416 bytes
Redo Buffers                   7897088 bytes

contents of Memory Script:
{
   sql clone "alter system set  db_name =
 ''PAGOFP'' comment=
 ''Reset to original value by RMAN'' scope=spfile";
   sql clone "alter system reset  db_unique_name scope=spfile";
}
executing Memory Script

sql statement: alter system set  db_name =  ''PAGOFP'' comment= ''Reset to original value by RMAN'' scope=spfile

sql statement: alter system reset  db_unique_name scope=spfile
Oracle instance started

Total System Global Area    2147478480 bytes

Fixed Size                     8874960 bytes
Variable Size                855638016 bytes
Database Buffers            1275068416 bytes
Redo Buffers                   7897088 bytes
sql statement: CREATE CONTROLFILE REUSE SET DATABASE "PAGOFP" RESETLOGS ARCHIVELOG
  MAXLOGFILES     40
  MAXLOGMEMBERS      3
  MAXDATAFILES     1024
  MAXINSTANCES     8
  MAXLOGHISTORY      292
 LOGFILE
  GROUP    10  SIZE 1 G ,
  GROUP    20  SIZE 1 G ,
  GROUP    30  SIZE 1 G ,
  GROUP    40  SIZE 1 G
 DATAFILE
  '+DATA/PAGOFP/DATAFILE/system.307.1158682259'
 CHARACTER SET AL32UTF8


contents of Memory Script:
{
   set newname for clone tempfile  1 to new;
   switch clone tempfile all;
   catalog clone datafilecopy  "+DATA/PAGOFP/DATAFILE/spiderbase.313.1158682339",
 "+DATA/PAGOFP/DATAFILE/sysaux.309.1158682305",
 "+DATA/PAGOFP/DATAFILE/undotbs1.315.1158682365",
 "+DATA/PAGOFP/DATAFILE/bmibase.316.1158682365",
 "+DATA/PAGOFP/DATAFILE/users.311.1158682305",
 "+DATA/PAGOFP/DATAFILE/e2fdatosbase.312.1158682339",
 "+DATA/PAGOFP/DATAFILE/eicdatosbase.306.1158682259",
 "+DATA/PAGOFP/DATAFILE/undotbs1.314.1158682341",
 "+DATA/PAGOFP/DATAFILE/eicdatosbase.310.1158682305",
 "+DATA/PAGOFP/DATAFILE/eicdatosbase.308.1158682259",
 "+DATA/PAGOFP/DATAFILE/eicdatosbase.317.1158682365";
   switch clone datafile all;
}
executing Memory Script

executing command: SET NEWNAME

renamed tempfile 1 to +DATA in control file

cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/spiderbase.313.1158682339 RECID=1 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/sysaux.309.1158682305 RECID=2 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/undotbs1.315.1158682365 RECID=3 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/bmibase.316.1158682365 RECID=4 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/users.311.1158682305 RECID=5 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/e2fdatosbase.312.1158682339 RECID=6 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.306.1158682259 RECID=7 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/undotbs1.314.1158682341 RECID=8 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.310.1158682305 RECID=9 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.308.1158682259 RECID=10 STAMP=1158682685
cataloged datafile copy
datafile copy file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.317.1158682365 RECID=11 STAMP=1158682686

datafile 2 switched to datafile copy
input datafile copy RECID=1 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/spiderbase.313.1158682339
datafile 3 switched to datafile copy
input datafile copy RECID=2 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/sysaux.309.1158682305
datafile 4 switched to datafile copy
input datafile copy RECID=3 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/undotbs1.315.1158682365
datafile 5 switched to datafile copy
input datafile copy RECID=4 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/bmibase.316.1158682365
datafile 7 switched to datafile copy
input datafile copy RECID=5 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/users.311.1158682305
datafile 8 switched to datafile copy
input datafile copy RECID=6 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/e2fdatosbase.312.1158682339
datafile 9 switched to datafile copy
input datafile copy RECID=7 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.306.1158682259
datafile 10 switched to datafile copy
input datafile copy RECID=8 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/undotbs1.314.1158682341
datafile 11 switched to datafile copy
input datafile copy RECID=9 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.310.1158682305
datafile 12 switched to datafile copy
input datafile copy RECID=10 STAMP=1158682685 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.308.1158682259
datafile 13 switched to datafile copy
input datafile copy RECID=11 STAMP=1158682686 file name=+DATA/PAGOFP/DATAFILE/eicdatosbase.317.1158682365

contents of Memory Script:
{
   Alter clone database open resetlogs;
}
executing Memory Script

database opened
Reenabling controlfile options for auxiliary database
Executing: alter database flashback on
Finished Duplicate Db at 19-JAN-24

RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of release command at 01/19/2024 16:18:36
RMAN-06012: channel: t1 not allocated

Recovery Manager complete.

[1]+  Exit 1                  nohup rman target sys/oracle1@ENTITID auxiliary / cmdfile=duplicate_PAGOFP.cmd log=duplicate_PAGOFP.log


Fallo porque no cerro el canal

***********************************************************************************************************
oracle19@sun2236c:~/duplicate_yb$
oracle19@sun2236c:~/duplicate_yb$

oracle19@sun2236c:~/duplicate_yb$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Fri Jan 19 16:19:14 2024
Version 19.13.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.13.0.0.0



