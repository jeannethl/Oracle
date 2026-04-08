


TRZSP 	-TRZSP1 sun1120p
		-TRZSP3 sun2120p

ls -ld /oracle/binarios/PATCH_DATAPUMP
ls -ld /oracle/binarios/Backup

		
0.1.- Verificar Objetos Invalidos.

		vi 01_Objetos_Invalidos.sql
		
			COLUMN object_name FORMAT A50
			column OWNER format a30
			set pagesize 1000
			SELECT owner
			      ,object_type
			      ,object_name
			      ,status
			 FROM dba_objects
			WHERE status = 'INVALID'
			ORDER BY owner, object_type, object_name;


1.- PRERREQUISITOS

	1.1- Backup ORACLE_BASE / ORAINVENTORY
	
			tar -pcvf oracle_base_bkup.tar /oracle/app/oracle
			--tar -pcvf grid_base_bkup.tar /oracle/app/oracle
			--tar -pcvf grid_home_bkup.tar /oracle/app/grid/product/19c/grid
			tar -pcvf orainventory_bkup.tar /oracle/app/oraInventory

	
	1.2- Verificar Parches anteriores
	
			$ORACLE_HOME/OPatch/opatch lspatches
			$ORACLE_HOME/OPatch/opatch lsinventory


--1.3 Bajar Nodos (Para este Parche)
--$ORACLE_HOME/bin/crsctl stop  crs
--$ORACLE_HOME/bin/crsctl start crs
--verificar nombre db -srvctl config database
--verificar nombre db - srvctl config database -d TRZS -a
--srvctl stop instance -d TRZS -i TRZS3



2.- Instalacion Parche (PATCH_DATAPUMP/34734035)

	cd /oracle/binarios/PATCH_DATAPUMP/34734035
	$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./


	$ORACLE_HOME/OPatch/opatch apply


	2.1 Validar Parchado
	
		$ORACLE_HOME/OPatch/opatch lspatches
		$ORACLE_HOME/OPatch/opatch lsinventory


3.- Correr Datapatch (Se realiza en un solo nodo)

	$ORACLE_HOME/
	./datapatch


04.- Verificar Objetos Invalidos.

		vi 01_Objetos_Invalidos.sql
		
			COLUMN object_name FORMAT A50
			column OWNER format a30
			set pagesize 1000
			SELECT owner
			      ,object_type
			      ,object_name
			      ,status
			 FROM dba_objects
			WHERE status = 'INVALID'
			ORDER BY owner, object_type, object_name;

	4.1.- Compilar Objetos Invalidos
		
		@?/rdbms/admin/utlrp.sql

