BACK_UP_RESTORE rman

01_BACKUP_OFFLINE
02_RESTORE_OFFLINE


**en el proximo backup crer el directory donde se va a crear todos los archivos .dmp que sea uno solo

01_BACKUP_OFFLINE

*dbtrzsp
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
backup current controlfile
       tag RESPALDO_CTL_TRZSP_LIMIO_PREP
       format '/exportdb/TRZSP/CON_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESPALDO_DBF_TRZSP_LIMPIO_PREP
       format '/exportdb/TRZSP/CON_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/TRZSP/CON_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_TRZSP_LIMPIO_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
release channel d5;
release channel d6;
release channel d7;
release channel d8;  
}

23:04 23:06

shutdown immediate;

srvctl start database -d TRZSP

--srvctl status database -d TRZSP
srvctl status instance -d TRZSP -i TRZSP1



****

02_RESTORE_OFFLINE

02.1.- Bajar Base de Datos 
	ORACLE:
srvctl stop database -d TRZSP

02.2.- Limpiar ASM
	GRID:
asmcmd
lsdg

	02.2.1 Limpiar +DATA_TRZSP
	
		02.2.1.1 Borrar DATAFILE

			+DATA_TRZSP/TRZSP/DATAFILE
			pwd
				rm *

		02.2.1.2 Borrar CONTROLFILE
	
			+DATA_TRZSP/TRZSP/CONTROLFILE
			pwd
				rm *

		02.2.1.3 Borrar TEMFILE
	
			+DATA_TRZSP/TRZSP/TEMFILE
			pwd
				rm *


	02.2.2 Limpiar +FRA

		02.2.2.1 Borrar ARCHIVELOG

			+FRA/TRZSP/ARCHIVELOG
			pwd
				rm *

		02.2.2.2 Borrar AUTOBACKUP

			+FRA/TRZSP/AUTOBACKUP
			pwd
				rm *

		02.2.2.3 Borrar CONTROLFILE

			+FRA/TRZSP/CONTROLFILE
			pwd
				rm *

		02.2.2.4 Borrar FLASHBACK

			+FRA/TRZSP/FLASHBACK
			pwd
				rm *



	02.2.3 Limpiar +REDO01 / +REDO02

		2.3.1 Borrar ONLINELOG REDO01

			+REDO01_TRZSP/TRZSP
				rm -fr ONLINELOG 

		2.3.2 Borrar ONLINELOG REDO02

			+REDO02_TRZSP/TRZSP
				rm -fr ONLINELOG

02.3.- Hacer RESTORE RMAN

	ORACLE:

	3.1 Entrar a RMAN
	
		rman target /


	3.1.1 Subir BD NO MOUNT

		startup nomount 

	3.1.2 Correr Restore del CONTROLFILE

		restore controlfile from '/exportdb/TRZSP/CON_TABLESPACES_FULL/Control_TRZSP_6i35p3v4_210';

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
}


	02.3.2.1 Abrir BD

		alter database open resetlogs;
		





