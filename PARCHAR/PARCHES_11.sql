parche : 19855835 
=================

cd /oracle/instaladores/parches 

unzip p19855835_112040_Generic.zip

chmod -R 777 19855835

cd 19855835

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

opatch apply



parche : 20907061
=================

cd /oracle/instaladores/parches 

unzip p20907061_112040_Linux-x86-64.zip

chmod -R 777 20907061

cd 20907061

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

srvctl stop database -d SUPERDB

opatch apply





parche : 20476175 
=================

cd /oracle/instaladores/parches 

unzip p20476175_112040_Linux-x86-64.zip

chmod -R 777 20476175

cd 20476175

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

srvctl stop database -d SUPERDB

opatch apply 



parche : 20879889
=================

cd /oracle/instaladores/parches 

unzip p20879889_112040_Linux-x86-64.zip

chmod -R 777 20879889 PatchSearch.xml

cd 20879889

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

srvctl stop database -d SUPERDB

opatch apply 




parche : 19174639
=================

cd /oracle/instaladores/parches

unzip p19174639_112040_Linux-x86-64.zip

chmod -R 777 19174639

cd 19174639

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

srvctl stop database -d SUPERDB

opatch apply



partche : 24739928
==================

cd /oracle/instaladores/parches

unzip p24739928_112040_Linux-x86-64.zip

chmod -R 777 24739928 PatchSearch.xml

cd 24739928

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

opatch apply



parche : 18498878 
================= 

cd /oracle/instaladores/parches

unzip p18498878_112040_Linux-x86-64.zip

chmod -R 777 18498878 PatchSearch.xml

cd 18498878

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

srvctl stop database -d SUPERDB

opatch apply



parche : 22113854
=================

cd /oracle/instaladores/parches

unzip p22113854_112040_Generic.zip

chmod -R 777 22113854

cd 22113854

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

opatch apply

ejecutar por cada base de datos :
--------------------------------- 

    sqlplus /nolog
    CONNECT / AS SYSDBA
    @?/sqlpatch/22113854/postinstall.sql




--NO APLICAR
parche : 23665623 -> 28072567 
=============================

cd /oracle/instaladores/parches

unzip p28072567_112040_Linux-x86-64.zip

chmod -R 777 28072567 

cd 28072567

opatch prereq CheckConflictAgainstOHWithDetail -ph ./

[oracle@lsrhdb1911 28072567]$ opatch prereq CheckConflictAgainstOHWithDetail -ph ./
Oracle Interim Patch Installer version 11.2.0.3.4
Copyright (c) 2012, Oracle Corporation.  All rights reserved.

PREREQ session

Oracle Home       : /oracle/app/oracle/product/11.2.0.4/db1
Central Inventory : /oracle/app/oraInventory
   from           : /oracle/app/oracle/product/11.2.0.4/db1/oraInst.loc
OPatch version    : 11.2.0.3.4
OUI version       : 11.2.0.4.0
Log file location : /oracle/app/oracle/product/11.2.0.4/db1/cfgtoollogs/opatch/opatch2025-05-20_07-35-30AM_1.log

Invoking prereq "checkconflictagainstohwithdetail"

ZOP-40: The patch(es) has conflicts with other patches installed in the Oracle Home (or) among themselves.

Prereq "checkConflictAgainstOHWithDetail" failed.

Summary of Conflict Analysis:

There are no patches that can be applied now.

Following patches have conflicts. Please contact Oracle Support and get the merged patch of the patches :
20476175, 28072567

Following patches will be rolled back from Oracle Home on application of the patches in the given list :
20476175

Conflicts/Supersets for each patch are:

Patch : 28072567

        Conflict with 20476175
        Conflict details:
        /oracle/app/oracle/product/11.2.0.4/db1/lib/libserver11.a:/qksbg.o

OPatch succeeded.
