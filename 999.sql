lote13

CREATE INDEX "TX"."IDX_DOER_PARTY" ON "TX"."DOER" ("PARTYID", "PARTYENTITYGUID", "TRANID", "SEQ")

Index created.

Elapsed: 00:17:25.29


lote 4
CREATE INDEX "TX"."IDX_OBJPROPLOG_PROPCHANGEDAY" ON "TX"."OBJPROPLOG" ("TABLEGUID", "OBJECTPID", "PROPERTYGUID", "OPERDAY")
CREATE INDEX "TX"."IDX_OBJPROPLOG_PROPCHANGEDAY" ON "TX"."OBJPROPLOG" ("TABLEGUID", "OBJECTPID", "PROPERTYGUID", "OPERDAY")
                  *
ERROR at line 1:
ORA-00955: name is already used by an existing object


Elapsed: 00:12:23.20

Index altered.

Elapsed: 00:00:00.00


CREATE INDEX "TX"."IDX_OBJPROPLOG_USERPROPTIME" ON "TX"."OBJPROPLOG" ("USERNAME", "TABLEGUID", "OBJECTPID", "PROPERTYGUID", "CHANGETIME")

Index created.

Elapsed: 00:04:14.42

Index altered.

Elapsed: 00:00:00.00


CREATE UNIQUE INDEX "TX"."PK_RDX_DBSESSIONVARS" ON "TX"."RDX_DBSESSIONVARS" ("NAME")
CREATE UNIQUE INDEX "TX"."PK_RDX_DBSESSIONVARS" ON "TX"."RDX_DBSESSIONVARS" ("NAME")
                                                        *
ERROR at line 1:
ORA-14451: unsupported feature with temporary table


Elapsed: 00:00:00.00





lote 1
CREATE UNIQUE INDEX "TX"."PK_DOEREXTMSG" ON "TX"."DOEREXTMSG" ("TRANID", "DOERSEQ")
CREATE UNIQUE INDEX "TX"."PK_DOEREXTMSG" ON "TX"."DOEREXTMSG" ("TRANID", "DOERSEQ")
                         *
ERROR at line 1:
ORA-00955: name is already used by an existing object


Elapsed: 00:05:34.05

Index altered.

Elapsed: 00:00:00.01

CREATE INDEX "TX"."IDX_DOER_PARTY" ON "TX"."DOER" ("PARTYID", "PARTYENTITYGUID", "TRANID", "SEQ")
                  *
ERROR at line 1:
ORA-00955: name is already used by an existing object


Elapsed: 00:11:43.78

Index altered.

Elapsed: 00:00:00.00



lote 3
CREATE INDEX "TX"."IDX_DOER_MATCH" ON "TX"."DOER" ("KEY", "PARTYID", "PARTYENTITYGUID", "ROLE", "PARENTROLEPATH", "TRANID")

Index created.

Elapsed: 00:19:43.55

Index altered.

Elapsed: 00:00:00.00



lote 5
CREATE INDEX "TX"."IDX_POSTING_ACCOUNTDAY" ON "TX"."POSTING" ("ACCOUNTID", "OPERDAY", "POSTINGSEQ")
CREATE INDEX "TX"."IDX_POSTING_ACCOUNTDAY" ON "TX"."POSTING" ("ACCOUNTID", "OPERDAY", "POSTINGSEQ")
                  *
ERROR at line 1:
ORA-00955: name is already used by an existing object


Elapsed: 00:11:14.11






