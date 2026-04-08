* Actividades previas al Backup y Restore --Caso BDVEMP


CREAR_VERIFICAR_DBLINK --ver que exista conexion 
string de conexión sun1001

BDVEMPPSRV_sun1001 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = sun001scan)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = BDVEMPPSRV.BANVENEZ.CORP)
    )
  )


CREATE PUBLIC DATABASE LINK BDVEMPSUN1001 CONNECT TO SYSTEM IDENTIFIED BY k3r3p4kup41 USING 'BDVEMPPSRV_sun1001';

DROP PUBLIC DATABASE LINK PRUEBA;


col OWNER format a20
col DB_LINK format a20
col USERNAME format a20
col HOST format a20
col CREATED format a20
SELECT * FROM DBA_DB_LINKS;




Verificar

SELECT * FROM dual@BDVEMPSUN1001;



VERIFICAR_CREAR_CIRECTORY --IMP

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;


CREATE OR REPLACE DIRECTORY MIGRACION AS '/exportdb/CANALP/IMP_BDVPICP_CANALP';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;

01_BACKUP_OFFLINE


ssh oracle19@plclsb01

rman target /


 list backup summary;
 crosscheck backup;
 delete backup;
 list backup summary;


/exportdb/BDVEMP/BK_TABLESPACES_FULL

srvctl status database -d BDVEMPP
srvctl stop database -d BDVEMPP

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
backup current controlfile
       tag RESPALDO_CTL_BDVEMP_LIMPIO_PREP
       format '/exportdb/BDVEMP/BK_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESPALDO_DBF_BDVEMP_LIMPIO_PREP
       format '/exportdb/BDVEMP/BK_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/BDVEMP/BK_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_BDVEMP_LIMPIO_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
release channel d5;
release channel d6;
release channel d7;
release channel d8;  
}


shutdown immediate;

srvctl start database -d BDVEMPP
--srvctl status instance -d BDVEMP -i CANALP1


********************************************************************
02_RESTORE_OFFLINE

02.1.- Bajar Base de Datos 
	ORACLE:
srvctl status database -d BDVEMPP
srvctl stop database -d BDVEMPP


02.2.- Limpiar ASM
	GRID:
asmcmd
lsdg

	02.2.1 Limpiar +DATA_BDVEMP
	
		02.2.1.1 Borrar DATAFILE

			+DATA_EMP/BDVEMPP/DATAFILE
			pwd
				rm *

		02.2.1.2 Borrar CONTROLFILE
	
			+DATA_EMP/BDVEMPP/CONTROLFILE
			pwd
				rm *

		02.2.1.3 Borrar TEMFILE
	
			+DATA_EMP/BDVEMPP/TEMPFILE
			pwd
				rm *


	02.2.2 Limpiar +FRA

		02.2.2.1 Borrar ARCHIVELOG

			+FRA/BDVEMPP/ARCHIVELOG
			pwd
				rm *

		02.2.2.2 Borrar AUTOBACKUP

			+FRA/BDVEMPP/AUTOBACKUP
			pwd
				rm *

		02.2.2.3 Borrar CONTROLFILE

			+FRA/BDVEMPP/CONTROLFILE
			pwd
				rm *

		02.2.2.4 Borrar FLASHBACK

			+FRA/BDVEMPP/FLASHBACK
			pwd
				rm *



	02.2.3 Limpiar +REDO01 / +REDO02

		2.3.1 Borrar ONLINELOG REDO01

			+REDO01_EMP/BDVEMPP
				rm -fr ONLINELOG 

		2.3.2 Borrar ONLINELOG REDO02

			+REDO02_EMP/BDVEMPP
				rm -fr ONLINELOG

02.3.- Hacer RESTORE RMAN

	ORACLE:

	3.1 Entrar a RMAN
	
		rman target /


	3.1.1 Subir BD NO MOUNT

		startup nomount 

	3.1.2 Correr Restore del CONTROLFILE

		restore controlfile from '/exportdb/BDVEMP/BK_TABLESPACES_FULL/Control_BDVEMPP_7r3mt1bf_251';

	3.1.3 Pasar BD a MOUNT

		alter database mount;

02.3.2 Correr Restore de DATAFILES

run {
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
allocate channel d5 type disk; 
allocate channel d6 type disk;
allocate channel d7 type disk;
catalog start with '/exportdb/BDVEMP/BK_TABLESPACES_FULL/';
restore database;
recover database;
release channel d1; 
release channel d2;
release channel d3; 
release channel d4;
release channel d5; 
release channel d6;
release channel d7; 
}


	02.3.2.1 Abrir BD

		alter database open resetlogs;
		

--FLASHBACK
ALTER DATABASE FLASHBACK OFF;

--ARCHIVELOG
archive log list;

alter system switch logfile;
alter system switch logfile;
alter system checkpoint;

srvctl stop database -d BDVEMPP

>sqlplus
startup mount;
alter database noarchivelog;
alter database open;
archive log list;




srvctl start database -d BDVEMPP


mount -o rw,hard,intr,timeo=600,proto=tcp,bg,rsize=1045876,wsize=1045876 172.27.88.64:/migrate /migra
































