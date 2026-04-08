#PROCEDIMIENTOS REALIZADOS PARA HACER RESTORE DESDE UNA BD.
--------------------------------------------------------------------------
1) 'INGRESO CON USUARIO ORACLE Y SE BAJA LA BASE DE DATOS'

oracle11@sun1331p:/oracle11$ sqlplus / as sysdba

SQL*Plus: Release 11.2.0.4.0 Production on Fri Oct 20 16:00:40 2023

Copyright (c) 1982, 2013, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, Automatic Storage Management, OLAP, Data Mining
and Real Application Testing options

SQL> shutdown immdiate;

--------------------------------------------------------------------------
2) 'INGRESO CON USUARIO GRID A ASM Y BORRAR LOS DATAFILES QUE EXISTEN EN EL DISKGROUP DE DATA'

$ asmcmd 
ASMCMD> lsdg	
State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512   4096  1048576    102388    75958                0           75958              0             N  DG_DATA_DIMENP/
MOUNTED  EXTERN  N         512   4096  1048576    102388    98249                0           98249              0             N  DG_FRA/
MOUNTED  EXTERN  N         512   4096  1048576      5114     1171                0            1171              0             N  DG_REDO01_DIMENP/
MOUNTED  EXTERN  N         512   4096  1048576      5114     1171                0            1171              0             N  DG_REDO02_DIMENP/

ASMCMD> cd DG_DATA_DIMENP/
ASMCMD> ls
ASM/
DIMENP/
ASMCMD> cd DIMENP/
ASMCMD> ls
DATAFILE/
PARAMETERFILE/
TEMPFILE/
ASMCMD> cd DATAFILE/
ASMCMD> ls
DATA_AUDITORIA.269.1150536239
DATA_AUDITORIA.270.1150536239
PCMS_DATA.263.1150536183
PCMS_IDX.268.1150536237
PCMS_RBS.266.1150536185
SYSAUX.257.1150472857
SYSAUX.264.1150536185
SYSTEM.256.1150472857
SYSTEM.262.1150536183
UNDOTBS1.258.1150472857
UNDOTBS1.265.1150536185
USERS.259.1150472857
USERS.267.1150536185
ASMCMD> rm -rf *

--------------------------------------------------------------------------------------------------------------
3) 'INGRESO CON USUARIO GRID A ASM Y BORRAR LOS CONTROLFILE QUE EXISTEN LOS DISKGROUP DE REDO Y EN FRA'

ASMCMD> cd +DG_REDO01_DIMENP/
ASMCMD> ls
DIMENP/
ASMCMD> rm -rf *
ASMCMD> cd +DG_REDO02_DIMENP/
ASMCMD> ls
DIMENP/
ASMCMD> rm -rf *
ASMCMD> cd +DG_FRA/
ASMCMD> ls
DIMENP/
ASMCMD> rm -rf *

--------------------------------------------------------------------------------------------------------------
4) 'SE MODIFICA EL PFILE, BORRANDO LA RUTA DEL CONTROL SOLO DEJANDO LA RUTA DE LOS DISKGROUPS'

$ cd $ORACLE_HOME
$ cp -p initDIMENP.ora initDIMENP.ora.bck
$
$ vi initDIMENP.ora
-------------------------------------------------------
*.control_files='+DG_REDO01_DIMENP','+DG_REDO02_DIMENP'

# Se deja la línea del control_file, tal como se muestra en la referencia de arriba.
-------------------------------------------------------

5) 'SE INGRESA VÍA SQLPLUS A LA INSTANCIA Y SE DEJA EN ESTADO NOMOUNT (STARTED), SETEANDO EL INIT MODIFICADO'

$ sqlplus / as sysdba

SQL> startup nomount pfile='initDIMENP.ora';

ORACLE instance started.
Total System Global Area 4277059584 bytes
Fixed Size                  2188408 bytes
Variable Size             889199496 bytes
Database Buffers         3372220416 bytes
Redo Buffers               13451264 bytes

SQL> select status from v$instance;

STATUS
------------
STARTED

--------------------------------------------------------------------------------------------------------------


6) 'SE INGRESA VÍA RMAN AL CATALOGO PARA EJECUTAR EL RESTORE DE LOS CONTROLFILE DESDE EL ORIGEN'

$ rman target / catalog rmanp/rmanexport@RMAN12

Recovery Manager: Release 11.2.0.4.0 - Production on Fri Oct 20 16:14:32 2023

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

connected to target database: DIMENP (not mounted)
connected to recovery catalog database
-------------------------------
RMAN> set DBID=1373088591

	# Se setea con el DBID de la Base de Datos de Origen.
	# Se consulta en la BD de origen con el query: 
	# SQL> SELECT DBID FROM V$DATABASE;
-------------------------------
-------------------------------------------------------------------------
RMAN> run
{
set until time "to_date('12-OCT-2023 02:00:00','dd-mm-yyyy hh24:mi:ss')";
allocate channel t1 type 'SBT_TAPE';
send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=DIMENP_ONL_SEM,NSR_CLIENT=sun18pz1)';
RESTORE CONTROLFILE;
release channel t1;
}
-------------------------------------------------------------------------
executing command: SET until clause
allocated channel: t1
channel t1: SID=130 device type=SBT_TAPE
channel t1: NMDA Oracle v19.2.1.3
sent command to channel: t1
Starting restore at 20-OCT-23
channel t1: starting datafile backup set restore
channel t1: restoring control file
channel t1: reading from backup piece DIMENP_CONTROLFILE_20231012_28725
channel t1: piece handle=DIMENP_CONTROLFILE_20231012_28725 tag=TAG20231012T010446
channel t1: restored backup piece 1
channel t1: restore complete, elapsed time: 00:00:07
output file name=+DG_REDO01_DIMENP/dimenp/controlfile/current.260.1150733869
output file name=+DG_REDO02_DIMENP/dimenp/controlfile/current.260.1150733871
Finished restore at 20-OCT-23

released channel: t1

RMAN> EXIT
Recovery Manager complete.


		----------------------------------------------
		#QUERY EJECUTADO:
		run
		{
		set until time "to_date('12-OCT-2023 02:00:00','dd-mm-yyyy hh24:mi:ss')";
		allocate channel t1 type 'SBT_TAPE';
		send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=DIMENP_ONL_SEM,NSR_CLIENT=sun18pz1)';
		RESTORE CONTROLFILE;
		release channel t1;
		}
		----------------------------------------------
--------------------------------------------------------------------------------------------------------------
7) 'SE INGRESA VÍA SQLPLUS PARA COLOCAR LA INSTANCIA EN MODO MOUNT'

$ sqlplus / as sysdba

SQL> ALTER DATABASE MOUNT;

Database altered.

SQL> SELECT STATUS FROM V$INSTANCE;

STATUS
------------
MOUNTED
--------------------------------------------------------------------------------------------------------------

8) 'SE MODIFICA EL PFILE, AGREGANDO LA RUTA DE LOS CONTROL RESTAURADOS'

$ vi initDIMENP.ora
	
	-------------------------------------------------------
	*.control_files='+DG_REDO01_DIMENP/DIMENP/CONTROLFILE/current.260.1150733869','+DG_REDO02_DIMENP/DIMENP/CONTROLFILE/current.260.1150733871'

	# Se deja la línea del control_file, tal como se muestra en la referencia de arriba.
	-------------------------------------------------------


9) 'SE REALIZA EL RESTORE DE LA BASE DE DATOS DESDE ARCHIVO POR NOHUP'
	---------------------

	AGREGAR EN UN ARCHIVO EL SIGUIENTE QUERY:

		run
		{
		set until time "to_date('23-OCT-2023 11:00:00','dd-mm-yyyy hh24:mi:ss')";
		allocate channel t1 type 'SBT_TAPE';
		allocate channel t2 type 'SBT_TAPE';
		send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=DIMENP_ONL_SEM,NSR_CLIENT=sun18pz1)';
		RESTORE DATABASE;
		RECOVER DATABASE;
		release channel t1;
		release channel t2;
		}

	EJECUTAR EL ARCHIVO CREADO.
	---------------------	
	nohup rman target / catalog rmand/rmanexport@rman19 cmdfile=NOMBRE_ARCHIVO.cmd LOG=NOMBRE_ARCHIVO.log &



10) 'FINALIZADO EL RESTORE, INGRESAR A LA BASE DE DATOS Y ABRIRLA CON RESETLOG'

	SQL> ALTER DATABSE OPEN RESETLOG;

11) 'ABRIR BASE DE DATOS CON UPGRADE'

	SQL> ALTER DATABASE OPEN UPGRADE;


12) 'EL ESTATUS DE LA BD ESTA EN OPEN MIGRATE POR LO QUE SE PROCEDE A CORRER EL QUERI CATUPGRD.SQL'

	SQL> @catupgrd.sql

13) 'SE REINICIA LA BASE DE DATOS'
	
	SQL> SHUTDOWN IMMEDIATE;
	SQL> STARTUP;
	SQL> SELECT STATUS FROM V$INSTANCE;

14) 'SE VERIFICA QUE NO TENGA OBJETOS INVALIDOS'

SQL> SET LINESIZE 200
SQL> SELECT OBJECT_NAME, OWNER, SUBOBJECT_NAME FROM DBA_OBJECTS WHERE STATUS='INVALID';

15) 'DE POSEER OBJETOS INVALIDOS CORRER EL QUERY: @utlrp.sql'

SQL> @utlrp.sql

16) 'VERIFICAR ESTATUS CORRECTO DE LA BD Y OBJETOS INVALIDOS EN 0'

SQL> SET LINESIZE 200
SQL> SELECT INSTANCE_NAME, HOST_NAME, STARTUP_TIME, STATUS FROM V$INSTANCE;

SQL> SET LINESIZE 200
SQL> SELECT OBJECT_NAME, OWNER, SUBOBJECT_NAME FROM DBA_OBJECTS WHERE STATUS='INVALID';


17) 'VERIFICAR QUE EL SPFILE ESTÉ CREADO'

SQL> SHOW PARAMETERS SPFILE;

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
spfile                               string      /oracle/app/oracle/product/11.
                                                 2.0/db/dbs/spfileDIMENP.ora

           EN VALUE DEBERÍA ESTAR LA RUTA DONDE SE ENCUENTRA EL SPFILE.

18) 'CREACIÓN DEL SPFILE' (OPCIONAL)


SQL> CREATE SPFILE='+DG_DATA_DIMENP/' FROM PFILE='/oracle/app/oracle/product/11.2.0/db/dbs/initDIMENP.ora';

ó 

SQL> CREATE SPFILE FROM PFILE;


	18.1) 'SE REINICIA LA BASE DE DATOS'
	
		SQL> SHUTDOWN IMMEDIATE;
		SQL> STARTUP;


	18.2) 'VERIFICAR'

		SQL> SHOW PARAMETERS SPFILE;
