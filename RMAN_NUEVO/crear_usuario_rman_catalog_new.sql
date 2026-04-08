
Name:   bdvsun01.banvenez.com
Address: 180.183.194.23

oracle10:RMAN11.BANVENEZ.COM
oracle9i:RMAN11.BANVENEZ.COM
 
Name:   bdvsun09.banvenez.corp
Address: 180.183.193.154
oracle10:RMAN11 
Name:   bdvsun04.banvenez.com
Address: 180.183.194.85
 
Name:   sun33.banvenez.corp
Address: 180.183.202.64
 
Name:   bdvsun010.banvenez.com
Address: 180.183.201.23
 
Name:   bdvsun02.banvenez.com
Address: 180.183.194.26
 
Name:    bdvsun07.banvenez.corp
Address:  180.183.194.216
 
Name:   sun14p.banvenez.corp
Address: 180.183.140.160
 
Name:   sun16n1.banvenez.corp
Address: 180.183.156.222
 
Name:   sun16n2.banvenez.corp
Address: 180.183.156.223
 
Name:   sun30n1.banvenez.corp
Address: 180.183.202.11
 
Name:   sun30n2.banvenez.corp
Address: 180.183.202.12
 
Name:   sun1001.banvenez.corp
Address: 180.183.202.101
 
Name:   sun1003p.banvenez.corp
Address: 180.183.202.131
 
Name:   sun2003p.banvenez.corp
Address: 180.183.202.133
 
Name:   sun1004p.banvenez.corp
Address: 172.27.56.20
 
Name:   sun2004p.banvenez.corp
Address: 172.27.56.22
 
Name:   sun1309p.banvenez.corp
Address: 172.27.56.152
 
Name:   sun1331p.banvenez.corp
Address: 172.27.56.130
 
Name:   sun2104p.banvenez.corp
Address: 180.183.194.75
 
Name:   sun2106p.banvenez.corp
Address: 180.183.194.252
 
Name:   sun2107p.banvenez.corp
Address: 180.183.194.253
 
Name:   sun2109p.banvenez.corp
Address: 180.183.145.60
 
Name:   sun2312.banvenez.corp
Address: 180.183.202.121
 
Name:   sun2319p.banvenez.corp
Address: 180.183.202.129




rman target / rcvcat rmanq/rmanexport@rman11
rman target / rcvcat rmanp/rmanexport@rman11
rman target / rcvcat rmand/rmanexport@rman11
rman target / rcvcat rman/rmanexport@rman11

rman target / rcvcat rmanq/rmanexport@rman11.banvenez.com
rman target / rcvcat rmanp/rmanexport@rman11.banvenez.com
rman target / rcvcat rmand/rmanexport@rman11.banvenez.com
rman target / rcvcat rman/rmanexport@rman11.banvenez.corp
rman target / rcvcat rman/rmanexport@RMAN.BANVENEZ.COM
rman target / rcvcat rman/rmanexport@rman19

rman target / rcvcat rmand/rmanexport@RMAN19

rman target / rcvcat rmanp/rmanexport@rmanh1


rman target / rcvcat rman/rmanexport@rman19

select * from rmand.rc_database;

select * from rmand.rc_database WHERE NAME LIKE '%INTRNETD%';


sqlplus SYSTEM/k3r3p4kup41@//180.183.242.4:1521/RMAN11


CREATE USER RMAN11
  IDENTIFIED BY rmanexport
  DEFAULT TABLESPACE DATA
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

-- 2 Roles for RMAN 
GRANT CONNECT TO RMAN11;
GRANT RECOVERY_CATALOG_OWNER TO RMAN11;
ALTER USER RMAN11 DEFAULT ROLE ALL;

-- 1 System Privilege for RMAN 
GRANT CREATE TYPE TO RMAN11;

-- 2 Tablespace Quotas for RMAN 
ALTER USER RMAN11 QUOTA UNLIMITED ON DATA;
ALTER USER RMAN11 QUOTA UNLIMITED ON INDX;

-- 1 Object Privilege for RMAN 
GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO RMAN11;


CREATE USER RMAND
  IDENTIFIED BY rmanexport
  DEFAULT TABLESPACE DATA_RMAND
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

-- 4 Roles for RMAND 
GRANT CONNECT TO RMAND;
GRANT DBA TO RMAND;
GRANT RECOVERY_CATALOG_OWNER TO RMAND;
GRANT RESOURCE TO RMAND;
ALTER USER RMAND DEFAULT ROLE ALL;

-- 1 System Privilege for RMAND 
GRANT UNLIMITED TABLESPACE TO RMAND;

-- Special Privileges for RMAND 
GRANT SYSOPER TO RMAND;

-- 1 Tablespace Quota for RMAND 
ALTER USER RMAND QUOTA UNLIMITED ON DATA_RMAND;





CREATE USER RMANP
  IDENTIFIED BY rmanexport
  DEFAULT TABLESPACE DATA_RMANP
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

-- 3 Roles for RMANP 
GRANT CONNECT TO RMANP;
GRANT RECOVERY_CATALOG_OWNER TO RMANP;
GRANT RESOURCE TO RMANP;
ALTER USER RMANP DEFAULT ROLE ALL;

-- 1 System Privilege for RMANP 
GRANT UNLIMITED TABLESPACE TO RMANP;

-- 2 Tablespace Quotas for RMANP 
ALTER USER RMANP QUOTA UNLIMITED ON DATA_RMAND;
ALTER USER RMANP QUOTA UNLIMITED ON DATA_RMANP;


CREATE USER RMANQ
  IDENTIFIED BY <password>
  DEFAULT TABLESPACE DATA_RMANQ
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

-- 4 Roles for RMANQ 
GRANT CONNECT TO RMANQ;
GRANT DBA TO RMANQ;
GRANT RECOVERY_CATALOG_OWNER TO RMANQ;
GRANT RESOURCE TO RMANQ;
ALTER USER RMANQ DEFAULT ROLE ALL;

-- 1 System Privilege for RMANQ 
GRANT UNLIMITED TABLESPACE TO RMANQ;

-- Special Privileges for RMANQ 
GRANT SYSOPER TO RMANQ;

-- 1 Tablespace Quota for RMANQ 
ALTER USER RMANQ QUOTA UNLIMITED ON DATA_RMANQ;



*************************************************************************

Ahora vamos con la creacion del usuario en el servidor de rman

SQL> CREATE USER RMAN_CBK
IDENTIFIED BY "CBK2020"
PROFILE DEFAULT
DEFAULT TABLESPACE RMAN
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON RMAN
ACCOUNT UNLOCK;
  2    3    4    5    6    7
User created.

SQL>


GRANT RECOVERY_CATALOG_OWNER TO RMAN_CBK;

GRANT CONNECT, RESOURCE TO RMAN_CBK;

alter user RMAN_CBK quota unlimited on RMAN;
*********************************************************************

Ahora desde el Servidor de CBK

[oracle@emcloud admin]$ rman target=/ catalog RMAN_CBK/CBK2020@RMANCATALOG;

Recovery Manager: Release 12.2.0.1.0 - Production on Thu Aug 27 19:42:26 2020

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

connected to target database: CBKPRD (DBID=2918091848)
connected to recovery catalog database


RMAN> CREATE CATALOG;

recovery catalog created

RMAN> REGISTER DATABASE;

database registered in recovery catalog
starting full resync of recovery catalog
full resync complete


RMAN> show all;

RMAN configuration parameters for database with db_unique_name ISTSINPRD are:
CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default
CONFIGURE CONTROLFILE AUTOBACKUP ON; # default
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE MAXSETSIZE TO UNLIMITED; # default
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
CONFIGURE ARCHIVELOG DELETION POLICY TO BACKED UP 2 TIMES TO DISK;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/u01/app/oracle/product/12.2.0/dbhome_1/dbs/snapcf_ISTSINPRD.f'; # default