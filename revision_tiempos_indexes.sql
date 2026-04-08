**LOTE 01

***Parallel 1 a 8
CREATE UNIQUE INDEX "TX"."PK_DOEREXTMSG" ON "TX"."DOEREXTMSG" ("TRANID", "DOERSEQ")
--Index created.
--Elapsed: 00:08:44.35
--Index altered.
--Elapsed: 00:00:00.00

CREATE INDEX "TX"."IDX_DOER_PARTY" ON "TX"."DOER" ("PARTYID", "PARTYENTITYGUID", "TRANID", "SEQ")
Index created.
Elapsed: 00:10:00.08
Index altered.
Elapsed: 00:00:00.00
--CREATE UNIQUE INDEX "TX"."PK_BALANCEHIST" ON "TX"."BALANCEHIST" ("DAY", "ACCOUNTID")
--                                                  *
--ERROR at line 1:
--ORA-14024: number of partitions of LOCAL index must equal that of the underlying table
--
--
--Elapsed: 00:00:00.02
--  ALTER INDEX "TX"."PK_BALANCEHIST" NOPARALLEL
--*
--ERROR at line 1:
--ORA-01418: specified index does not exist
--
--
--Elapsed: 00:00:00.00
--CREATE INDEX "TX"."IDX_BALANCEHIST_ACCOUNT" ON "TX"."BALANCEHIST" ("ACCOUNTID", "DAY")
--CREATE INDEX "TX"."IDX_BALANCEHIST_ACCOUNT" ON "TX"."BALANCEHIST" ("ACCOUNTID", "DAY")
--                                                    *
--ERROR at line 1:
--ORA-14024: number of partitions of LOCAL index must equal that of the underlying table
--
--
--Elapsed: 00:00:00.02
--  ALTER INDEX "TX"."IDX_BALANCEHIST_ACCOUNT" NOPARALLEL
--*
--ERROR at line 1:
--ORA-01418: specified index does not exist
--
--
--Elapsed: 00:00:00.00


**LOTE 02
CREATE UNIQUE INDEX "TX"."PK_DOER" ON "TX"."DOER" ("TRANID", "SEQ")
          *
ERROR at line 1:
ORA-00955: name is already used by an existing object
Elapsed: 00:11:45.82
Index altered.
Elapsed: 00:00:00.00




**LOTE 03

--CREATE INDEX "TX"."IDX_DOER_MATCH" ON "TX"."DOER" ("KEY", "PARTYID", "PARTYENTITYGUID", "ROLE", "PARENTROLEPATH", "TRANID")  --Parallel 32
--Index created.
--Elapsed: 00:18:36.35
--Index altered.
--Elapsed: 00:00:00.00



**LOTE 04

CREATE INDEX "TX"."IDX_OBJPROPLOG_PROPCHANGEDAY" ON "TX"."OBJPROPLOG" ("TABLEGUID", "OBJECTPID", "PROPERTYGUID", "OPERDAY")  
Index created.
Elapsed: 00:10:34.09
Index altered.
Elapsed: 00:00:00.00

CREATE INDEX "TX"."IDX_OBJPROPLOG_USERPROPTIME" ON "TX"."OBJPROPLOG" ("USERNAME", "TABLEGUID", "OBJECTPID", "PROPERTYGUID", "CHANGETIME")
Index created.
Elapsed: 00:04:34.70
Index altered.
Elapsed: 00:00:00.00

CREATE UNIQUE INDEX "TX"."PK_RDX_DBSESSIONVARS" ON "TX"."RDX_DBSESSIONVARS" ("NAME")
                                                        *
                                                        ERROR at line 1:
ORA-14451: unsupported feature with temporary table
Elapsed: 00:00:00.00



**LOTE 05

SP2-0734: unknown command beginning "prmpt CREA..." - rest of line ignored.
Index created.
Elapsed: 00:00:00.00

CREATE INDEX "TX"."IDX_POSTING_ACCOUNTDAY" ON "TX"."POSTING" ("ACCOUNTID", "OPERDAY", "POSTINGSEQ")
Index created.
Elapsed: 00:09:54.12
Index altered.
Elapsed: 00:00:00.00

CREATE INDEX "TX"."IDX_BATCHJOB_RID" ON "TX"."BATCHJOB" ("RID")
Index created.
Elapsed: 00:03:21.22
Index altered.
Elapsed: 00:00:00.00

CREATE UNIQUE INDEX "TX"."PK_BATCHJOB" ON "TX"."BATCHJOB" ("BATCHID", "THREADHASH", "ID")
Index created.
Elapsed: 00:01:41.85
Index altered.
Elapsed: 00:00:00.00

CREATE INDEX "TX"."IDX_BATCHJOB_BATCHSTATE" ON "TX"."BATCHJOB" ("BATCHID", "ISPROCESSED", "ID", "KIND", "THREADHASH")
Index created.
Elapsed: 00:01:24.39
Index altered.
Elapsed: 00:00:00.00

CREATE UNIQUE INDEX "TX"."PK_RDX_JS_THREADEDJOBPARAM" ON "TX"."RDX_JS_THREADEDJOBPARAM" ("JOBDUETIME", "JOBID", "NAME")
                                                              *
                                                              ERROR at line 1:
ORA-14024: number of partitions of LOCAL index must equal that of the underlying table
Elapsed: 00:00:00.00
  ALTER INDEX "TX"."PK_RDX_JS_THREADEDJOBPARAM" NOPARALLEL
  *
ERROR at line 1:
ORA-01418: specified index does not exist
Elapsed: 00:00:00.00


**LOTE 07

CREATE UNIQUE INDEX "TX"."PK_TRAN" ON "TX"."TRAN" ("ID")  --Parallel 32
Index created.
Elapsed: 00:09:55.51
Index altered.
Elapsed: 00:00:00.00



**LOTE 11

CREATE UNIQUE INDEX "TX"."PK_DOER" ON "TX"."DOER" ("TRANID", "SEQ")
Index created.
Elapsed: 00:11:48.44
Index altered.
Elapsed: 00:00:00.01



**LOTE 09

CREATE UNIQUE INDEX "TX"."PK_RDX_ENUMITEM2DOMAIN" ON "TX"."RDX_ENUMITEM2DOMAIN" ("VERSIONNUM", "ENUMID", "DOMAINID", "ENUMITEMVALASSTR")
Index created.
Elapsed: 00:00:00.01


CREATE UNIQUE INDEX "TX"."PK_OBJPROPLOG" ON TX.OBJPROPLOG(TABLEGUID, OBJECTPID, PROPERTYGUID, CHANGETIME, CHANGEID)
Index created.
Elapsed: 00:10:57.18
Index altered.
Elapsed: 00:00:00.00

