expdp full errors


*** Pending Area

20-SEP-24 09:25:55.714: ORA-39342: Internal error - failed to import internal objects tagged with RMGR due to ORA-29371: pending area is not active
.
20-SEP-24 09:25:55.850: ORA-39083: Object type PROCOBJ:"SYS"."ETL_GROUP" failed to create with error:

Failing sql is:
BEGIN
declare error_num1 exception;PRAGMA EXCEPTION_INIT(error_num1, -29357);begin dbms_resource_manager.create_consumer_group(consumer_group => 'ETL_GROUP', comment => 'Consumer group for ETL');exception when error_num1 then NULL;when others then raise; end;COMMIT; END;
20-SEP-24 09:25:55.850: ORA-39083: Object type PROCOBJ:"SYS"."DSS_GROUP" failed to create with error:
ORA-29371: pending area is not active

Failing sql is:
BEGIN
declare error_num1 exception;PRAGMA EXCEPTION_INIT(error_num1, -29357);begin dbms_resource_manager.create_consumer_group(consumer_group => 'DSS_GROUP', comment => 'Consumer group for DSS queries');exception when error_num1 then NULL;when others then raise; end;COMMIT; END;
20-SEP-24 09:25:55.850: ORA-39083: Object type PROCOBJ:"SYS"."INTERACTIVE_GROUP" failed to create with error:
ORA-29371: pending area is not active

Failing sql is:
BEGIN
declare error_num1 exception;PRAGMA EXCEPTION_INIT(error_num1, -29357);begin dbms_resource_manager.create_consumer_group(consumer_group => 'INTERACTIVE_GROUP', comment => 'Consumer group for interactive, OLTP operations');exception when error_num1 then NULL;when others then raise; end;COMMIT; END;
20-SEP-24 09:25:55.850: ORA-39083: Object type PROCOBJ:"SYS"."DSS_CRITICAL_GROUP" failed to create with error:
ORA-29371: pending area is not active

Failing sql is:
BEGIN
declare error_num1 exception;PRAGMA EXCEPTION_INIT(error_num1, -29357);begin dbms_resource_manager.create_consumer_group(consumer_group => 'DSS_CRITICAL_GROUP', comment => 'Consumer group for critical DSS queries');exception when error_num1 then NULL;when others then raise; end;COMMIT; END;
20-SEP-24 09:25:55.850: ORA-39083: Object type PROCOBJ:"SYS"."BATCH_GROUP" failed to create with error:
ORA-29371: pending area is not active

Failing sql is:
BEGIN
declare error_num1 exception;PRAGMA EXCEPTION_INIT(error_num1, -29357);begin dbms_resource_manager.create_consumer_group(consumer_group => 'BATCH_GROUP', comment => 'Consumer group for batch operations');exception when error_num1 then NULL;when others then raise; end;COMMIT; END;
20-SEP-24 09:25:55.850: ORA-39083: Object type PROCOBJ:"SYS"."LOW_GROUP" failed to create with error:
ORA-29371: pending area is not active

Failing sql is:
BEGIN
declare error_num1 exception;PRAGMA EXCEPTION_INIT(error_num1, -29357);begin dbms_resource_manager.create_consumer_group(consumer_group => 'LOW_GROUP', comment => 'Consumer group for low-priority sessions');exception when error_num1 then NULL;when others then raise; end;COMMIT; END;




20-SEP-24 09:26:44.877: ORA-39083: Object type REF_CONSTRAINT:"TX"."FK_FINCTRISSCREDITLIMIT" failed to create with error:
ORA-02270: no matching unique or primary key for this column-list




20-SEP-24 09:27:10.392: ORA-39082: Object type PROCEDURE:"TX"."KILL_DATABASE_SESSION" created with compilation warnings
--20-SEP-24 09:27:10.393: ORA-39082: Object type PROCEDURE:"BACKOFFICE"."MANTPARTITIONS" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type VIEW:"TX"."DOERCONTRACT" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type VIEW:"TX"."DOERINSTITUTION" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type VIEW:"TX"."DOERINTERFACE" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type VIEW:"TX"."DOERSUBJECT" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type VIEW:"TX"."DOERTERMINAL" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type VIEW:"TX"."DOERTOKEN" created with compilation warnings
--20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"BACKOFFICE"."MAINTENANCE" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."TRANSACTIONSMAINTENANCE" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."RDX_ARTE" created with compilation warnings
--20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."CRYPTO" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."RDX_ARTE_UTILS" created with compilation warnings
--20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."RDX_SOAP" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."RDX_UTILS" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."RDX_LOCK" created with compilation warnings
20-SEP-24 09:27:10.393: ORA-39082: Object type PACKAGE BODY:"TX"."TRANSACTIONS" created with compilation warnings









crear index



crean CONSTRAINT

--ALTER TABLE "TX"."CARD" ADD CONSTRAINT "FK_CARD_USER" FOREIGN KEY ("PINSET ENABLE NOVALIDATEDBYCLERK")
--ALTER TABLE "TX"."CARD" ADD CONSTRAINT "FK_CARD_USER" FOREIGN KEY ("PINSET ENABLE NOVALIDATEDBYCLERK")
--                                                                   *
--ERROR at line 1:
--ORA-00904: "PINSET ENABLE NOVALIDATEDBYCLERK": invalid identifier
--





