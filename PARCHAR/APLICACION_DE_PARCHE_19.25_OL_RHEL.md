# APLICACION DE PARCHE 19.25 <!-- omit in toc -->

## Index <!-- omit in toc -->

- [1. Parches](#1-parches)
  - [1.1. OPatch 12.2.0.1.45 for DB 19.0.0.0.0 (Jan 2025)](#11-opatch-1220145-for-db-190000-jan-2025)
  - [1.2. Grid Infrastructure Release Update 19.25.0.0.241015](#12-grid-infrastructure-release-update-192500241015)
  - [1.3. Oracle JavaVM (OJVM) Component Release Update 19.25.0.0.241015](#13-oracle-javavm-ojvm-component-release-update-192500241015)
  - [1.4. Monthly Recommended Patches (MRPs) 19.25.0.0.250218](#14-monthly-recommended-patches-mrps-192500250218)
    - [1.4.1. GI MRP 19.25.0.0.250218](#141-gi-mrp-192500250218)
    - [1.4.2. DATABASE MRP 19.25.0.0.250218](#142-database-mrp-192500250218)
- [2. Enviroment](#2-enviroment)
- [3. Primero se debe aplicar el OPatch en los binarios de grid y oracle](#3-primero-se-debe-aplicar-el-opatch-en-los-binarios-de-grid-y-oracle)
  - [3.1. OPatch en Oracle](#31-opatch-en-oracle)
  - [3.2. OPatch en Grid](#32-opatch-en-grid)
  - [3.3. Validar versión de OPatch en ambos `$ORACLE_HOME`](#33-validar-versión-de-opatch-en-ambos-oracle_home)
- [4. Backup de binarios](#4-backup-de-binarios)
  - [4.1. Backup](#41-backup)
  - [4.2. Restore (en caso de ser necesario)](#42-restore-en-caso-de-ser-necesario)
- [5. VALIDACION DE PREREQUISITOS](#5-validacion-de-prerequisitos)
  - [5.1. Como usuario grid](#51-como-usuario-grid)
  - [5.2. Como usuario oracle](#52-como-usuario-oracle)
- [6. OPatch System Space Check](#6-opatch-system-space-check)
  - [6.1. Create file /tmp/patch\_list\_gihome.txt with the following content](#61-create-file-tmppatch_list_gihometxt-with-the-following-content)
  - [6.2. Run the OPatch command to check if enough free space is available in the Grid Infrastructure home](#62-run-the-opatch-command-to-check-if-enough-free-space-is-available-in-the-grid-infrastructure-home)
- [7. Con el usuario oracle](#7-con-el-usuario-oracle)
  - [7.1. Create file /tmp/patch\_list\_dbhome.txt with the following content](#71-create-file-tmppatch_list_dbhometxt-with-the-following-content)
  - [7.2. Run OPatch command to check if enough free space is available in the Oracle home](#72-run-opatch-command-to-check-if-enough-free-space-is-available-in-the-oracle-home)
- [8. INSTALACION DE RU GRID/ORACLE](#8-instalacion-de-ru-gridoracle)
  - [8.1. INSTALAR RU GRID](#81-instalar-ru-grid)
  - [8.2. INSTALAR RU ORACLE](#82-instalar-ru-oracle)
- [9. INSTALAR OJVM](#9-instalar-ojvm)
  - [9.1. Descomprimir parche p36878697](#91-descomprimir-parche-p36878697)
  - [9.2. Check conflicts](#92-check-conflicts)
  - [9.3. Apply parche p36878697](#93-apply-parche-p36878697)
  - [9.4. Correr datapatch](#94-correr-datapatch)
- [10. Patch 37546429 - GI MRP 19.25.0.0.250218](#10-patch-37546429---gi-mrp-192500250218)
  - [10.1. Descomprimir el parche 37546429](#101-descomprimir-el-parche-37546429)
  - [10.2. Apply parche 37546429](#102-apply-parche-37546429)
- [11. Patch 37546427 DATABASE MRPs 19.25.0.0.250218](#11-patch-37546427-database-mrps-192500250218)
  - [11.1. Bajar servivios](#111-bajar-servivios)
    - [11.1.1. CLUSTER](#1111-cluster)
    - [11.1.2. SINGLE](#1112-single)
  - [11.2. Descomprimir el parche 37546427](#112-descomprimir-el-parche-37546427)
  - [11.3. Check conflicts 37546427](#113-check-conflicts-37546427)
  - [11.4. Apply parche p37546427](#114-apply-parche-p37546427)
  - [11.5. Start in CLUSTER](#115-start-in-cluster)
  - [11.6. start in SINGLE](#116-start-in-single)
- [12. Oracle Database Patch For Bug# 37104910 for Linux-x86-64 Platforms](#12-oracle-database-patch-for-bug-37104910-for-linux-x86-64-platforms)
  - [12.1. List of Bugs](#121-list-of-bugs)
  - [12.2. Stop services](#122-stop-services)
    - [12.2.1. Stop services in Cluster](#1221-stop-services-in-cluster)
    - [12.2.2. Stop services in single](#1222-stop-services-in-single)
  - [12.3. Unzip patch](#123-unzip-patch)
  - [12.4. Check prerequisites](#124-check-prerequisites)
  - [12.5. Apply patch](#125-apply-patch)
  - [12.6. Start services](#126-start-services)
    - [12.6.1. Start service in cluster](#1261-start-service-in-cluster)
    - [12.6.2. Start services in single](#1262-start-services-in-single)
  - [12.7. Executed datapatch](#127-executed-datapatch)
  - [12.8. Start services](#128-start-services)
    - [12.8.1. start services in Cluster](#1281-start-services-in-cluster)
    - [12.8.2. start services in single](#1282-start-services-in-single)
  - [12.9. Start services](#129-start-services)
    - [12.9.1. start services in Cluster](#1291-start-services-in-cluster)
    - [12.9.2. start services in single](#1292-start-services-in-single)
- [13. Evidencias cuando existe BD instalada](#13-evidencias-cuando-existe-bd-instalada)
  - [13.1. VERIFICAR EL REGISTRY CUANDO HAY BD INSTALADA](#131-verificar-el-registry-cuando-hay-bd-instalada)
- [14. VALIDAR OBJETOS INVALIDOS](#14-validar-objetos-invalidos)
- [15. VALIDAR EL HISTORICO DE PARCHES](#15-validar-el-historico-de-parches)

## 1. Parches

### 1.1. OPatch 12.2.0.1.45 for DB 19.0.0.0.0 (Jan 2025)

p6880880_190000_Linux-x86-64.zip

### 1.2. Grid Infrastructure Release Update 19.25.0.0.241015

p36916690_190000_Linux-x86-64.zip

### 1.3. Oracle JavaVM (OJVM) Component Release Update 19.25.0.0.241015

p36878697_190000_Linux-x86-64.zip

### 1.4. Monthly Recommended Patches (MRPs) 19.25.0.0.250218

#### 1.4.1. GI MRP 19.25.0.0.250218

p37546429_1925000DBRU_Linux-x86-64.zip

#### 1.4.2. DATABASE MRP 19.25.0.0.250218

p37546427_1925000DBRU_Linux-x86-64.zip

## 2. Enviroment

```bash
ssh oracle19@180.183.171.180
ssh grid@180.183.171.180

oracle1

# Root

ssh administrator@180.183.171.180

rootbdv
```

## 3. Primero se debe aplicar el OPatch en los binarios de grid y oracle

### 3.1. OPatch en Oracle

```bash
cd $ORACLE_HOME
mv OPatch OPatch_old
# unzip -d $ORACLE_HOME /exportdb/parches/p6880880_190000_Linux-x86-64.zip
unzip -q /exportdb/parches/p6880880_190000_Linux-x86-64.zip
```

### 3.2. OPatch en Grid

Conectarse como grid

```bash
echo $ORACLE_HOME

#Output

/oracle/app/product/19c/grid
```

Conectarse como root a ir a la ruta anterior

```bash
cd /oracle/app/product/19c/grid/..
ls -ltr

chown grid grid/
```

Como usuario grid nuevamente

```bash
cd $ORACLE_HOME
mv OPatch OPatch_old
unzip -q /exportdb/parches/p6880880_190000_Linux-x86-64.zip
```

Devolver los cambios hecho como root

```bash
cd /oracle/app/product/19c/grid/..
ls -ltr
chown root grid/
```

### 3.3. Validar versión de OPatch en ambos `$ORACLE_HOME`

```bash
$ORACLE_HOME/OPatch/opatch version
```

> NOTA: ESTOS PASOS FUERON APLICADOS EN INSTALACIONES NUEVAS SIN BD CREADAS y CON BD CREADA

## 4. Backup de binarios

### 4.1. Backup

Ejecutar como usuario root

```bash
cd /exportdb/BDVNETH/backup_binarios
tar -cvlpzf binarios_grid_$(date +%Y%m%d_%H%M%S).tar.gz  /oracle/app/product/19c/grid &
tar -cvlpzf binarios_oracle_$(date +%Y%m%d_%H%M%S).tar.gz  /oracle/app/oracle/product/19c/db1 &


tar -pcvzf /exportdb/BDVNETH/backup_binarios/oracle_base_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/oracle19 &

tar -pcvzf /exportdb/BDVNETH/backup_binarios/grid_base_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/grid

tar -pcvzf /exportdb/BDVNETH/backup_binarios/grid_home_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/product/19c/

tar -pcvzf /exportdb/BDVNETH/backup_binarios/oraInventory_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/oraInventory &

```

### 4.2. Restore (en caso de ser necesario)

```bash
tar -xzvf binarios_oracle_$(date +%Y%m%d_%H%M%S).tar.gz /u01/app/oracle/product/19c/db_1
```

## 5. VALIDACION DE PREREQUISITOS

### 5.1. Como usuario grid

Descomprimir el parche `p36916690_190000_Linux-x86-64.zip`

```bash
cd /exportdb/parches/
unzip -q p36916690_190000_Linux-x86-64.zip
chmod -R 777 36916690/
chmod 777 PatchSearch.xml
```

```bash
export UNZIPPED_PATCH_LOCATION=/exportdb/parches/36866740

```

Si no tiene el opatch en el $PATH agregarlo

```bash
export PATH=$PATH:$ORACLE_HOME/OPatch:.
```

```bash
cat <<EOF > checkConflictGrid.sh
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36912597
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36917416
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36917397
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36940756
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36758186
EOF

chmod 775 checkConflictGrid.sh && ./$_ > checkConflictGrid.log
grep -c passed checkConflictGrid.log
```

### 5.2. Como usuario oracle

```bash
export UNZIPPED_PATCH_LOCATION=/exportdb/parches/36866740
```

Si no tiene el opatch en el $PATH agregarlo

```bash
export PATH=$PATH:$ORACLE_HOME/OPatch:.
```

```bash
cd /exportdb/parches/
cat <<EOF > checkConflictOracle.sh
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36912597
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/36916690/36917416
EOF

chmod 775 checkConflictOracle.sh && ./$_ > checkConflictOracle.log
grep -c passed checkConflictOracle.log
```

## 6. OPatch System Space Check

### 6.1. Create file /tmp/patch_list_gihome.txt with the following content

```bash
export UNZIPPED_PATCH_LOCATION=/exportdb/parches/36866740
```

```bash
cat <<EOT >>/tmp/patch_list_gihome.txt
$UNZIPPED_PATCH_LOCATION/36916690/36912597
$UNZIPPED_PATCH_LOCATION/36916690/36917416
$UNZIPPED_PATCH_LOCATION/36916690/36917397
$UNZIPPED_PATCH_LOCATION/36916690/36940756
$UNZIPPED_PATCH_LOCATION/36916690/36758186
EOT
```

### 6.2. Run the OPatch command to check if enough free space is available in the Grid Infrastructure home

```bash
$ORACLE_HOME/OPatch/opatch prereq CheckSystemSpace -phBaseFile /tmp/patch_list_gihome.txt
```

## 7. Con el usuario oracle

### 7.1. Create file /tmp/patch_list_dbhome.txt with the following content

```bash
export UNZIPPED_PATCH_LOCATION=/exportdb/parches/36866740
```

```bash
cat <<EOF > /tmp/patch_list_dbhome.txt
$UNZIPPED_PATCH_LOCATION/36916690/36912597
$UNZIPPED_PATCH_LOCATION/36916690/36917416
EOF
```

### 7.2. Run OPatch command to check if enough free space is available in the Oracle home

```bash
$ORACLE_HOME/OPatch/opatch prereq CheckSystemSpace -phBaseFile /tmp/patch_list_dbhome.txt
```

## 8. INSTALACION DE RU GRID/ORACLE

### 8.1. INSTALAR RU GRID

Como usuario **root**

```bash
su - root
export CV_ASSUME_DISTID=OL7 ## Para oracle linux 8
export UNZIPPED_PATCH_LOCATION=/exportdb/parches/36866740
export PATH=$PATH:/oracle/app/product/19c/grid/OPatch

cd /tmp
opatchauto apply $UNZIPPED_PATCH_LOCATION/36916690
```

### 8.2. INSTALAR RU ORACLE

En una nueva ventana

```bash
su - root
export CV_ASSUME_DISTID=OL7 ## Para oracle linux 8
export UNZIPPED_PATCH_LOCATION=/exportdb/parches/36866740
export PATH=$PATH:/oracle/app/oracle19/product/19c/db1/OPatch

cd /tmp
opatchauto apply $UNZIPPED_PATCH_LOCATION -oh /oracle/app/oracle/product/19c/db1
```

## 9. INSTALAR OJVM

CON ORACLE, se debe bajar la BD, si existe

```bash
sqlplus / as sysdba

shutdown immediate
```

### 9.1. Descomprimir parche p36878697

```bash
export PATCH_TOP_DIR=/exportdb/parches
cd $PATCH_TOP_DIR
mv PatchSearch.xml PatchSearch.xml.36866740

unzip -q p36878697_190000_Linux-x86-64.zip
chmod -R 777 36878697
chmod 777 PatchSearch.xml
```

### 9.2. Check conflicts

```bash
cd $PATCH_TOP_DIR/36878697
opatch prereq CheckConflictAgainstOHWithDetail -ph ./

opatch lspatches
```

### 9.3. Apply parche p36878697

```bash
cd $PATCH_TOP_DIR/36878697
opatch apply
```

### 9.4. Correr datapatch

Este paso aplica si exite una BD creada, sino **omitir**

```bash
cd $ORACLE_HOME/OPatch
./datapatch -verbose
```

## 10. Patch 37546429 - GI MRP 19.25.0.0.250218

### 10.1. Descomprimir el parche 37546429

con el usuario grid

```bash
export PATCH_TOP_DIR=/exportdb/parches
cd $PATCH_TOP_DIR
mv PatchSearch.xml PatchSearch.xml.$(date +'%H%S')

unzip -q p37546429_1925000DBRU_Linux-x86-64.zip
chmod -R 777 37546429/
```

### 10.2. Apply parche 37546429

CON ROOT

```bash
sudo su -
export PATCH_TOP_DIR=/exportdb/parches
export PATH=$PATH:/usr/ccs/bin:/oracle/app/product/19c/grid/OPatch
cd $PATCH_TOP_DIR/

opatchauto apply ./37546429 -analyze

opatchauto apply ./37546429
```

## 11. Patch 37546427 DATABASE MRPs 19.25.0.0.250218

### 11.1. Bajar servivios

#### 11.1.1. CLUSTER

CON ROOT

```bash
/oracle/app/product/19c/grid/bin/crsctl stop crs
```

#### 11.1.2. SINGLE

CON GRID

```bash
crsctl stop has
```

### 11.2. Descomprimir el parche 37546427

CON ORACLE

```bash
export PATCH_TOP_DIR=/exportdb/parches

cd $PATCH_TOP_DIR
mv PatchSearch.xml PatchSearch.xml.$(date +'%H%S')

unzip -q p37546427_1925000DBRU_Linux-x86-64.zip
chmod -R 777 37546427
chmod 777 PatchSearch.xml
```

### 11.3. Check conflicts 37546427

```bash
export PATH=$PATH:/usr/ccs/bin:.
export PATCH_TOP_DIR=/exportdb/parches
cd $PATCH_TOP_DIR/

$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./37546427

opatch lspatches
```

### 11.4. Apply parche p37546427

```bash
cd $PATCH_TOP_DIR/
$ORACLE_HOME/OPatch/opatch napply ./37546427 -verbose

opatch lspatches
```

### 11.5. Start in CLUSTER

CON ROOT

```bash
/oracle/app/product/19c/grid/bin/crsctl start crs
```

### 11.6. start in SINGLE

Con grid

```bash
crsctl start has
```

## 12. Oracle Database Patch For Bug# 37104910 for Linux-x86-64 Platforms

### 12.1. List of Bugs

ORACLE

p37104910_1923000DBRU_Linux-x86-64.zip - 37104910 ✅
p35197819_1923000DBRU_Linux-x86-64.zip - 35197819 ✅
p34774667_1923000DBRU_Linux-x86-64.zip - 34774667 ✅
p37166484_1923000DBRU_Linux-x86-64.zip - 37166484 ❌
p29213893_1923000DBRU_Generic.zip - 29213893 ✅
p36006910_1923000DBRU_Linux-x86-64.zip - 36006910 👨‍💻
36158909, 36285197, 36480774, 36587533, 37166484, 35077128

GRID
36427106, 35197819

Apply the same steps for each Patch bug

### 12.2. Stop services

#### 12.2.1. Stop services in Cluster

With root

```bash
/oracle/app/product/19c/grid/bin/crsctl stop crs
```

#### 12.2.2. Stop services in single

With Grid

```bash
crsctl stop has
```

### 12.3. Unzip patch

```bash
export PATCH_TOP_DIR=/exportdb/PATCHES
cd $PATCH_TOP_DIR
mv PatchSearch.xml PatchSearch.xml.$(date +'%H%S')

# Change patch name and dir

chmod 777 p36006910_1923000DBRU_Linux-x86-64.zip && unzip -q $_ 
chmod -R 777 36006910/
chmod 777 PatchSearch.xml
```

### 12.4. Check prerequisites

```bash
export PATCH_TOP_DIR=/exportdb/PATCHES
cd $PATCH_TOP_DIR/36006910

opatch prereq CheckConflictAgainstOHWithDetail -ph ./
```

### 12.5. Apply patch

```bash
cd $PATCH_TOP_DIR/36006910
opatch apply

opatch lspatches
```

### 12.6. Start services

#### 12.6.1. Start service in cluster

#### 12.6.2. Start services in single

```bash
crsctl start has
```

### 12.7. Executed datapatch

When finished the applied all patch for bugs, executed datapatch

```bash
cd $ORACLE_HOME/OPatch
./datapatch
```

### 12.8. Start services

#### 12.8.1. start services in Cluster

With root

```bash
/oracle/app/product/19c/grid/bin/crsctl start crs
```

#### 12.8.2. start services in single

With Grid

```bash
crsctl start has
```

### 12.9. Start services

#### 12.9.1. start services in Cluster

With root

```bash
/oracle/app/product/19c/grid/bin/crsctl start crs
```

#### 12.9.2. start services in single

With Grid

```bash
crsctl start has
```

## 13. Evidencias cuando existe BD instalada

Con oracle y grid

```bash
$ORACLE_HOME/OPatch/opatch lsinventory
$ORACLE_HOME/OPatch/opatch lspatches
```

### 13.1. VERIFICAR EL REGISTRY CUANDO HAY BD INSTALADA

```sql
set timi on 
set time on
set line 380
set pagesize 50
col comp_name format a50
col status format a10
select comp_name, version, VERSION_FULL, status from dba_registry;
```

```sql
set line 180 pages 300
SELECT patch_id,
SOURCE_VERSION,
TARGET_VERSION,
PATCH_TYPE,
DESCRIPTION
-- bundle_id
-- bundle_series
FROM dba_registry_sqlpatch;
```

## 14. VALIDAR OBJETOS INVALIDOS

```sql
select OWNER
      ,OBJECT_NAME
      ,OBJECT_TYPE
      ,STATus  
  from dba_objects
where status = 'INVALID';
```

## 15. VALIDAR EL HISTORICO DE PARCHES

```sql
set line 180 pages 300
col action_time for a40
col action for a12
col namespace for a10
col version for a22
col comments for a80
SELECT TO_CHAR(action_time, 'YYYY-MM-DD HH24:MI') AS DATE_APPLY
      ,action
      ,namespace
      ,version
      ,comments
--    ,bundle_series
  FROM sys.registry$history
 ORDER by action_time;
```

```sql
$ORACLE_HOME/OPatch/datapatch -verbose
```
