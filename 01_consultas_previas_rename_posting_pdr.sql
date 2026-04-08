

**.Consultas_previas_rename

00. Validar_Objetos_Invalidos (Antes CDC)
01. Consultar_indices_tabla_posting
02. Consultar_constraint_tabla_posting
03. Consultar_trigger_tabla_posting
04. Get_DDL_Metadata_Tabla_Posting
05. Get_DDL_Index_Tabla_Posting (en caso de que falte - corroborrar con TOAD)
06. Get_DDL_Trigger_Tabla_Posting

******************************************************************************

00. Validar Objetos Invalidos

vi 00_objetos_invalidos.sql

	spool 00_objetos_invalidos.lst
		set timi on time on
		set line 240
		
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

	spool off;



01. Consultar_indices_tabla_posting

vi 01_Consultar_indices_tabla_posting.sql

	spool 01_Consultar_indices_tabla_posting.lst
		set timi on time on
		set line 240
		SELECT 'ALTER INDEX '||OWNER||'.'||INDEX_NAME||' RENAME TO '||INDEX_NAME||'_BK;'
		FROM DBA_INDEXES
		WHERE TABLE_NAME IN ('POSTING')
		AND OWNER='TX';
	spool off;


02. Consultar_constraint_tabla_posting

vi 02_Consultar_constraint_tabla_posting.sql

	spool 02_Consultar_constraint_tabla_posting.lst
	set timi on time on
	set line 240
		SELECT 'ALTER TABLE '||OWNER||'.'||TABLE_NAME||' RENAME CONSTRAINT '||CONSTRAINT_NAME||' TO '||CONSTRAINT_NAME||'_BK;'
		FROM DBA_CONSTRAINTS
		WHERE TABLE_NAME IN ('POSTING')
		AND OWNER='TX';
	spool off;



03. Consultar_trigger_tabla_posting

vi 03_Consultar_trigger_tabla_posting.sql

	spool 03_Consultar_trigger_tabla_posting.lst
	set timi on time on
	set line 240
		COL OWNER FORMAT A30
		COL TRIGGER_NAME FORMAT A30
		COL TABLE_NAME FORMAT A30
		COL TRIGGERING_EVENT FORMAT A40
		SELECT OWNER, TRIGGER_NAME, TABLE_NAME, STATUS, TRIGGER_TYPE, TRIGGERING_EVENT
		FROM ALL_TRIGGERS
		WHERE TABLE_NAME = 'POSTING';
	spool off;

--03.1.-

--SELECT OWNER, TRIGGER_NAME, TRIGGER_BODY
--FROM ALL_TRIGGERS
--WHERE TRIGGER_NAME = 'TBIR_POSTING';



04. Get_DDL_Metadata_Tabla_Posting

vi 04_Get_DDL_Metadata_Tabla_Posting.sql
	
	spool 04_Get_DDL_Metadata_Tabla_Posting.lst
	set timi on time on
	set line 240
		SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 lineESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
		BEGIN
		   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
		   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
		END;
		/
		
		SELECT dbms_metadata.get_ddl('TABLE','POSTING','TX') FROM dual;
	spool off;




05. Get_DDL_Index_Tabla_Posting (en caso de que no lo genere - corroborrar con TOAD)

vi 05_Get_DDL_Index_Tabla_Posting.sql
	
	spool 05_Get_DDL_Index_Tabla_Posting.lst
	set timi on time on
	set line 240
		SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 lineESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
		BEGIN
		   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
		   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
		END;
		/
		SELECT dbms_metadata.get_ddl('INDEX','IDX_POSTING_ACCOUNTDAY','TX') FROM dual;
	spool off;



06. Get_DDL_Trigger_Tabla_Posting

vi 06_Get_DDL_Trigger_Tabla_Posting.sql

	spool 06_Get_DDL_Trigger_Tabla_Posting.lst
	set timi on time on
	set line 240
		SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 lineESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
		BEGIN
		   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
		   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
		END;
		/
		SELECT dbms_metadata.get_ddl('TRIGGER','TBIR_POSTING','TX') FROM dual;
	spool off;
