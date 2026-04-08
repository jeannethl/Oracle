
**Rename_Tabla_Posting_PRD

Verificar indices, constraints, triggers (TOAD)


01. Rename_Tabla_Posting
02. Rename_Index_Table_Posting
03. Rename_Constraint_Table_Posting
04. Rename_Trigger_Table_Posting
05. Create_Table_Posting_Original (Vacia)
06. Create_Index (Faltante - verificado en TOAD)
07. Create_Trigger
08. Validar_Objetos_Invalidos (Despues CDC)

@01_rename_table_posting.sql
@02_rename_index_table_posting.sql
@03_rename_constraint_table_posting.sql
@04_rename_trigger_table_posting.sql
@05_create_table_posting.sql
@06_create_index_table_posting.sql
@07_create_trigger_table_posting.sql
@08_objetos_invalidos_despues_CDC.sql
@09_ultrp.sql





01. Rename_Tabla_Posting

vi 01_rename_table_posting.sql

	spool 01_rename_table_posting.lst
	set timi on time on
	set line 240
	
	ALTER TABLE TX.POSTING RENAME TO POSTING_BK;
	
	spool off;



02. Rename_Index_Table_Posting

vi 02_rename_index_table_posting.sql

	spool 02_rename_index_table_posting.lst
	set timi on time on
	set line 240
	
	ALTER INDEX TX.IDX_POSTING_ACCOUNTDAY RENAME TO IDX_POSTING_ACCOUNTDAY_BK;
	ALTER INDEX TX.PK_POSTING RENAME TO PK_POSTING_BK;
	
	spool off;


03. Rename_Constraint_Table_Posting

vi 03_rename_constraint_table_posting.sql

	spool 03_rename_constraint_table_posting.lst
	set timi on time on
	set line 240
	
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT FK_POSTING_ACCOUNT TO FK_POSTING_ACCOUNT_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT CKC_AMT_POSTING TO CKC_AMT_POSTING_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT CKC_BASEAMT_POSTING TO CKC_BASEAMT_POSTING_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011507 TO SYS_C0011507_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011508 TO SYS_C0011508_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011509 TO SYS_C0011509_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011510 TO SYS_C0011510_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011511 TO SYS_C0011511_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011512 TO SYS_C0011512_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011513 TO SYS_C0011513_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011514 TO SYS_C0011514_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011515 TO SYS_C0011515_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011516 TO SYS_C0011516_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT SYS_C0011517 TO SYS_C0011517_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT PK_POSTING TO PK_POSTING_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT FK_POSTING_ENTRYPART TO FK_POSTING_ENTRYPART_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT FK_POSTING_INSTITUTION TO FK_POSTING_INSTITUTION_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT FK_POSTING_TRAN TO FK_POSTING_TRAN_BK;
	ALTER TABLE TX.POSTING_BK RENAME CONSTRAINT UNQ_POSTING_ACCOUNTDAY TO UNQ_POSTING_ACCOUNTDAY_BK;
	
	spool off;


04. Rename_Trigger_Table_Posting

vi 04_rename_trigger_table_posting.sql

	spool 04_rename_trigger_table_posting.lst
	set timi on time on
	set line 240
	
	ALTER TRIGGER TX.TBIR_POSTING RENAME TO TBIR_POSTING_BK;
	
	spool off;



05. Create_Table_Posting_Original

vi 05_create_table_posting.sql

	spool 05_create_table_posting.lst
	set timi on time on
	set line 240
	
	CREATE TABLE "TX"."POSTING"
	   (    "ID" NUMBER(18,0) NOT NULL ENABLE,
	        "INSTID" NUMBER(18,0) NOT NULL ENABLE,
	        "ACCOUNTID" NUMBER(18,0) NOT NULL ENABLE,
	        "OPERDAY" DATE NOT NULL ENABLE,
	        "TRANID" NUMBER(18,0) NOT NULL ENABLE,
	        "ENTRYSEQ" NUMBER(9,0) NOT NULL ENABLE,
	        "ENTRYPARTSEQ" NUMBER(9,0) NOT NULL ENABLE,
	        "ENTRYKIND" VARCHAR2(100 CHAR) NOT NULL ENABLE,
	        "DOERROLE" VARCHAR2(100 CHAR),
	        "DOERPARENTROLEPATH" VARCHAR2(100 CHAR),
	        "FINOPERKIND" VARCHAR2(100 CHAR),
	        "REGISTERROLE" VARCHAR2(100 CHAR),
	        "CLASSIFICATION" VARCHAR2(4000 CHAR),
	        "CLASSIFICATIONFORGL" VARCHAR2(4000 CHAR),
	        "GLCODE" VARCHAR2(50 CHAR),
	        "SIGN" NUMBER(1,0) NOT NULL ENABLE,
	        "AMT" NUMBER NOT NULL ENABLE,
	        "BASEAMT" NUMBER,
	        "POSTINGSEQ" NUMBER(18,0) DEFAULT -1 NOT NULL ENABLE,
	         CONSTRAINT "CKC_AMT_POSTING" CHECK (AMT>=0) ENABLE,
	         CONSTRAINT "CKC_BASEAMT_POSTING" CHECK (BASEAMT>=0) ENABLE,
	         CONSTRAINT "UNQ_POSTING_ACCOUNTDAY" UNIQUE ("ACCOUNTID", "OPERDAY", "POSTINGSEQ") RELY DISABLE,
	         CONSTRAINT "FK_POSTING_ACCOUNT" FOREIGN KEY ("ACCOUNTID")
	          REFERENCES "TX"."ACCOUNT" ("ID") RELY ENABLE,
	         CONSTRAINT "FK_POSTING_ENTRYPART" FOREIGN KEY ("TRANID", "ENTRYSEQ", "ENTRYPARTSEQ")
	          REFERENCES "TX"."ENTRYPART" ("TRANID", "ENTRYSEQ", "SEQ") RELY DISABLE,
	         CONSTRAINT "FK_POSTING_INSTITUTION" FOREIGN KEY ("INSTID")
	          REFERENCES "TX"."INSTITUTION" ("ID") RELY DISABLE,
	         CONSTRAINT "FK_POSTING_TRAN" FOREIGN KEY ("TRANID")
	          REFERENCES "TX"."TRAN" ("ID") RELY DISABLE
	   ) SEGMENT CREATION IMMEDIATE
	  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
	 NOCOMPRESS LOGGING
	  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
	  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
	  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
	  TABLESPACE "RBS_POSTING" ;
	  CREATE UNIQUE INDEX "TX"."PK_POSTING" ON "TX"."POSTING" ("ID")
	  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
	  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
	  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
	  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
	  TABLESPACE "RBS_POSTING_IDX" ;
	ALTER TABLE "TX"."POSTING" ADD CONSTRAINT "PK_POSTING" PRIMARY KEY ("ID") RELY
	  USING INDEX "TX"."PK_POSTING"  ENABLE;
	
	spool off;




06. Create_Index (Faltante)

vi 06_create_index_table_posting.sql

	spool 06_create_index_table_posting.lst
	set timi on time on
	set line 240
	
	CREATE INDEX "TX"."IDX_POSTING_ACCOUNTDAY" ON "TX"."POSTING" ("ACCOUNTID", "OPERDAY", "POSTINGSEQ")
	  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
	  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
	  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
	  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
	  TABLESPACE "RBS_POSTING_IDX";
	
	spool off;

07. Create_Trigger

vi 07_create_trigger_table_posting.sql

	spool 07_create_trigger_table_posting.lst
	set timi on time on
	set line 240
	
	CREATE OR REPLACE EDITIONABLE TRIGGER "TX"."TBIR_POSTING" before insert on TX.POSTING for each row
	declare
	    acctPostId NUMBER(18,0);
	begin
	    if :new.POSTINGSEQ is null then -- TWRBS-27105 deprecated:
	        :new.POSTINGSEQ := SQN_POSTINGSEQ.nextval;
	        select LASTPOSTINGSEQ into  acctPostId from ACCOUNT where ACCOUNT.ID = :new.ACCOUNTID;
	        while :new.POSTINGSEQ <= acctPostId loop --for AADC
	            :new.POSTINGSEQ := SQN_POSTINGSEQ.nextval;
	        end loop;
	    end if;
	end;
	
	/

	spool off;


08. Validar_Objetos_Invalidos

vi 08_objetos_invalidos_despues_CDC.sql
	
	spool 08_objetos_invalidos_despues_CDC.lst
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

09. Ultrp
 
vi 09_ultrp.sql

	spool 09_ultrp.lst
		set timi on time on
		set line 240
		@?/rdbms/admin/utlrp.sql;
	
	spool off;
