BACK_UP_RESTORE rman

01_BACKUP_OFFLINE
02_RESTORE_OFFLINE


01_BACKUP_OFFLINE

;

rman target /


 list backup summary;
 --crosscheck backup;
 delete backup;
 list backup summary;

*dbtrzsp

srvctl status database -d TRZSP
srvctl stop database -d TRZSP


rman target /


startup mount


run { 
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk;
allocate channel d6 type disk;
allocate channel d7 type disk;
allocate channel d8 type disk;
allocate channel d9 type disk;
allocate channel d10 type disk;
backup database
       filesperset 3
       tag RESPALDO_DBF_TRZSP_LIMPIO_PREP
       format '/exportdb/TRZSP/CON_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/TRZSP/CON_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_TRZSP_LIMPIO_PREP;
backup current controlfile
       tag RESPALDO_CTL_TRZSP_LIMIO_PREP
       format '/exportdb/TRZSP/CON_TABLESPACES_FULL/Control_%d_%u_%s'; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
release channel d5;
release channel d6;
release channel d7;
release channel d8; 
release channel d9;
release channel d10; 
}


shutdown immediate;
startup;

srvctl status database -d TRZSP

--srvctl status database -d TRZSP
srvctl start instance -d TRZSP -i TRZSP1



****

02_RESTORE_OFFLINE

02.0 Limpiar carpertas previo a Migracion --Borrar .lst


cd /Migracion3/TRZS/scripts

./limpieza.sh

cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

./limpieza_ddl_index_trzsp.sh





02.1.- Bajar Base de Datos 

srvctl status database -d TRZSP
srvctl stop database -d TRZSP


02.2.- Limpiar ASM

asmcmd

lsdg

02.2.1 Limpiar +DATA_TRZSP

--datafiles	
cd +DATA_TRZSP/TRZSP/DATAFILE
pwd
rm *

--controlfile
cd +DATA_TRZSP/TRZSP/CONTROLFILE
pwd
rm *

--tempfile
cd +DATA_TRZSP/TRZSP/TEMPFILE
pwd
rm *


02.2.2 Limpiar +FRA_TRZSP / --+FRA02_TRZSP

--ARCHIVELOG
cd +FRA_TRZSP/TRZSP/ARCHIVELOG
--pwd
--rm * 
--CONTROLFILE
cd +FRA_TRZSP/TRZSP/CONTROLFILE
pwd
rm *

--FLASHBACK

--cd +FRA_TRZSP/TRZSP/FLASHBACK
--pwd
--rm *



02.2.3 Limpiar +REDO01 / +REDO02

--REDO01
cd +REDO01_TRZSP/TRZSP/ONLINELOG
pwd
rm *

--REDO02
cd +REDO02_TRZSP/TRZSP/ONLINELOG
pwd
rm *

02.3.- Hacer RESTORE RMAN

--Entrar a RMAN
rman target /

--Subir BD NO MOUNT
startup nomount 

--Restore del CONTROLFILE
restore controlfile from '/exportdb/TRZSP/CON_TABLESPACES_FULL/Control_TRZSP_vt37dee5_1021';

--BD a MOUNT
alter database mount;


--

File Name: +FRA_TRZSP/TRZSP/AUTOBACKUP/2024_10_08/s_1181822187.399.1181822283

--Restore de DATAFILES

run {
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk; 
allocate channel d6 type disk;
allocate channel d7 type disk; 
allocate channel d8 type disk;
allocate channel d9 type disk; 
catalog start with '/exportdb/TRZSP/CON_TABLESPACES_FULL/';
restore database;
recover database;
release channel d1; 
release channel d2;
release channel d3; 
release channel d4;
release channel d5; 
release channel d6;
release channel d7; 
release channel d8;
release channel d9; 
}




***********************monitoreo

 alter session set nls_date_format='dd-mon-rrrr hh24:mi:ss';
 select count(1), error ,time from v$recover_file group by error,time;



--Abrir BD
alter database open resetlogs;

--Reinicio
>SQL



alter system set DB_BLOCK_CHECKING=FALSE;
alter system set DB_BLOCK_CHECKSUM=OFF;

select FORCE_LOGGING from v$database;
alter database force logging;

alter system set "_dlm_stats_collect"=0 SCOPE=SPFILE;


alter system set "_OPTIMIZER_GATHER_STATS_ON_LOAD"=FALSE comment=' Best practice Datapumo import';
alter system set "_lm_share_lock_opt"=FALSE comment=' Best practice Datapumo import' scope=spfile; 

--CLUSTER_DATABASE
alter system set cluster_database=FALSE scope=spfile;
alter system set aq_tm_processes=40;



--FLASHBACK
ALTER DATABASE FLASHBACK OFF;

--ARCHIVELOG
archive log list;

alter system switch logfile;
alter system switch logfile;
alter system checkpoint;
shutdown immediate;

startup mount;

alter database noarchivelog;

alter database open;

archive log list;

cd /Migracion3/TRZS/scripts/
sqlplus / as sysdba @27_estadisticas.sql





