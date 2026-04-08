# APLICACION DE PARCHE 19.21

- p35742441_190000_Linux-x86-64.zip
- p36155925_1921000DBRU_Linux-x86-64.zip
- p36155938_1921000DBRU_Linux-x86-64.zip
- p6880880_190000_Linux-x86-64.zip

## Enviroment

```bash
ssh oracle19@180.183.171.180
ssh grid@180.183.171.180

oracle1

# Root

ssh administrator@180.183.171.180

rootbdv
```

## Primero se debe aplicar el OPatch en los binarios de grid y oracle

### OPatch en Oracle

```bash
$ORACLE_HOME/OPatch/opatch version
cd $ORACLE_HOME
mv OPatch OPatch_old
unzip -d $ORACLE_HOME /oracle/instaladores/parches/p6880880_190000_Linux-x86-64.zip
```

### OPatch en Grid

Conectarse como grid

```bash
echo $ORACLE_HOME

#Output

/oracle/app/product/19c/grid
```

Conectarse como root a ir a la ruta anterior

```bash
$ORACLE_HOME/OPatch/opatch version
cd /oracle/app/product/19c/grid/..
cd ..
ls -ltr

chown grid grid/
```

Como usuario grid nuevamente

```bash
cd $ORACLE_HOME
mv OPatch OPatch_old
unzip -d $ORACLE_HOME /oracle/instaladores/parches/p6880880_190000_Linux-x86-64.zip
```

Devolver los cambios hecho como root

```bash
cd /oracle/app/product/19c/grid/..
ls -ltr
chown root grid/
```

### Validar versión de OPatch en ambos `$ORACLE_HOME`

```bash
$ORACLE_HOME/OPatch/opatch version
```

> NOTA: ESTOS PASOS FUERON APLICADOS EN INSTALACIONES NUEVAS SIN BD CREADAS y CON BD CREADA

## Backup de binarios

### Backup

Ejecutar como usuario root

```bash
cd /exportdb/backup_binarios
tar -cvlpzf binarios_grid_$(date +%Y%m%d_%H%M%S).tar.gz  /oracle/app/product/19c/grid/
tar -cvlpzf binarios_oracle_$(date +%Y%m%d_%H%M%S).tar.gz  /oracle/app/oracle/product/19c/db1


tar -pcvzf /exportdb/backup_binarios/oracle_base_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/oracle

tar -pcvzf /exportdb/backup_binarios/grid_base_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/grid

tar -pcvzf /exportdb/backup_binarios/grid_home_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/product/19c/

tar -pcvzf /exportdb/backup_binarios/oraInventory_$(date +%Y%m%d_%H%M%S).tar.gz /oracle/app/oraInventory

```

### Restore

```bash
tar -xzvf binarios_oracle_$(date +%Y%m%d_%H%M%S).tar.gz /u01/app/oracle/product/19c/db_1
```

## VALIDACION DE PREREQUISITOS

### Como usuario grid

Descomprimir el parche `p35742441_190000_Linux-x86-64.zip`

```bash
cd /oracle/instaladores/parches/
unzip -q p35742441_190000_Linux-x86-64.zip
chmod -R 777 35742441/
```

```bash
export UNZIPPED_PATCH_LOCATION=/oracle/instaladores/parches/35742441
```

Si no tiene el opatch en el $PATH agregarlo

```bash
export PATH=$PATH:$ORACLE_HOME/OPatch:.
```

```bash
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/35643107

$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/35655527

$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/35652062

$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/35553096

$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/33575402
```

### Como usuario oracle

```bash
export UNZIPPED_PATCH_LOCATION=/oracle/instaladores/parches/35742441
```

Si no tiene el opatch en el $PATH agregarlo

```bash
export PATH=$PATH:$ORACLE_HOME/OPatch:.
```

```bash
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/35643107
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -phBaseDir $UNZIPPED_PATCH_LOCATION/35642822/35655527
```

## Con el usuario Grid

### Create file /tmp/patch_list_gihome.txt with the following content

```bash
export UNZIPPED_PATCH_LOCATION=/oracle/instaladores/parches/35742441
```

```bash
cat <<EOF > /tmp/patch_list_gihome.txt
$UNZIPPED_PATCH_LOCATION/35642822/35643107
$UNZIPPED_PATCH_LOCATION/35642822/35655527
$UNZIPPED_PATCH_LOCATION/35642822/35652062
$UNZIPPED_PATCH_LOCATION/35642822/35553096
$UNZIPPED_PATCH_LOCATION/35642822/33575402
EOF
```

### Run the OPatch command to check if enough free space is available in the Grid Infrastructure home

```bash
$ORACLE_HOME/OPatch/opatch prereq CheckSystemSpace -phBaseFile /tmp/patch_list_gihome.txt
```

## Con el usuario oracle

### Create file /tmp/patch_list_dbhome.txt with the following content

```bash
export UNZIPPED_PATCH_LOCATION=/oracle/instaladores/parches/35742441
```

```bash
cat <<EOF > /tmp/patch_list_dbhome.txt
$UNZIPPED_PATCH_LOCATION/35642822/35643107
$UNZIPPED_PATCH_LOCATION/35642822/35655527
EOF
```

### Run OPatch command to check if enough free space is available in the Oracle home

```bash
$ORACLE_HOME/OPatch/opatch prereq CheckSystemSpace -phBaseFile /tmp/patch_list_dbhome.txt
```

## INSTALACION DE RU GRID

### INSTALAR RU GRID

Como usuario **root**

```bash
su - root
export CV_ASSUME_DISTID=OL7 ## Para oracle linux 8
export UNZIPPED_PATCH_LOCATION=/oracle/instaladores/parches/35742441
export PATH=$PATH:/oracle/app/product/19c/grid/OPatch ->home de grid

cd /tmp
opatchauto apply $UNZIPPED_PATCH_LOCATION/35642822
```

### INSTALAR RU ORACLE

En una nueva ventana

```bash
su - root
export CV_ASSUME_DISTID=OL7 ## Para oracle linux 8
export UNZIPPED_PATCH_LOCATION=/oracle/instaladores/parches/35742441

export PATH=$PATH:/oracle/app/oracle/product/19c/db1/OPatch

cd /tmp
opatchauto apply $UNZIPPED_PATCH_LOCATION/35642822 -oh /oracle/app/oracle/product/19c/db1
```

### INSTALAR OJVM

CON ORACLE, se debe bajar la BD, si existe

```bash
sqlplus / as sysdba

shutdown immediate
```

```bash
export PATCH_TOP_DIR=/oracle/instaladores/parches/35742441
export PATH=$PATH:/oracle/app/oracle/product/19c/db1/OPatch
export PATH=$PATH:$ORACLE_HOME/perl/bin
export PERL5LIB=$ORACLE_HOME/perl/lib

cd $PATCH_TOP_DIR/35648110
opatch prereq CheckConflictAgainstOHWithDetail -ph ./

opatch lsinventory
opatch lspatches

cd $PATCH_TOP_DIR/35648110
opatch apply
```

Error presentado, si no se realiza la exportación de las variables `$PERL5LIB` y agregar el bin de perl en el `$PATH`:

```bash
OUI-67200:Make failed to invoke "/usr/bin/make -f ins_rdbms.mk javavm_refresh ORACLE_HOME=/oracle/app/oracle/product/19c/db1 OPATCH_SESSION=apply"....'make: perl: Command not found'
make: *** [ins_rdbms.mk:573: javavm_refresh] Error 127
```

Solution:

```bash
export PATH=$ORACLE_HOME/perl/bin:$PATH
export PERL5LIB=$ORACLE_HOME/perl/lib

Patching fails during relink , with error code 102 :: Fatal error: Command failed for target `javavm_refresh' (Doc ID 2002334.1)
```

### Correr datapatch

Este paso aplica si exite una BD creada, sino **omitir**

```bash
cd $ORACLE_HOME/OPatch
./datapatch -verbose
```

## Patch 36155925 DATABASE MRP 19.21.0.0.240116

echo $ORACLE_HOME

CON ROOT

### CLUSTER

```bash
/oracle/app/product/19c/grid/bin/crsctl stop crs
```

### SINGLE

```bash
/oracle/app/product/19c/grid/bin/crsctl stop has
```

Con oracle

### Descomprimir el parche 36155925

```bash
export PATCH_TOP_DIR=/oracle/instaladores/parches

cd $PATCH_TOP_DIR
mv PatchSearch.xml PatchSearch.xml_35742441

unzip -q p36155925_1921000DBRU_Linux-x86-64.zip
chmod -R 777 36155925
```

```bash
export PATCH_TOP_DIR=/oracle/instaladores/parches
cd $PATCH_TOP_DIR/
$ORACLE_HOME/OPatch/opatch prereq CheckConflictAgainstOHWithDetail -ph ./36155925

$ORACLE_HOME/OPatch/opatch napply ./36155925 -verbose
```

### Start in CLUSTER

CON ROOT

```bash
/oracle/app/product/19c/grid/bin/crsctl start crs
```

### start in SINGLE

Con grid

```bash
crsctl start has
```

## Patch 36155938 - GI MRP 19.21.0.0.240116

### Descomprimir el parche 36155938

con el usuario grid

```bash
export PATCH_TOP_DIR=/oracle/instaladores/parches

cd $PATCH_TOP_DIR
mv PatchSearch.xml PatchSearch.xml_36155925

unzip -q p36155938_1921000DBRU_Linux-x86-64.zip
chmod -R 777 36155938/
```

### Ejecutar el parche 36155938

CON ROOT

```bash
sudo su -
export PATCH_TOP_DIR=/oracle/instaladores/parches
export PATH=$PATH:/oracle/app/product/19c/grid/OPatch
cd $PATCH_TOP_DIR/

opatchauto apply ./36155938 -analyze

opatchauto apply ./36155938

```

## Evidencias

Con oracle y grid

```bash
$ORACLE_HOME/OPatch/opatch lsinventory
$ORACLE_HOME/OPatch/opatch lspatches
```

### VERIFICAR EL REGISTRY

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
SELECT patch_id,
version,
status,
bundle_id,
-- bundle_series
FROM dba_registry_sqlpatch;
```

## VALIDAR OBJETOS INVALIDOS

```sql
select OWNER
      ,OBJECT_NAME
      ,OBJECT_TYPE
      ,STATus  
  from dba_objects
where status = 'INVALID';
```

## VALIDAR EL HISTORICO DE PARCHES

```sql
col action_time for a40
col action for a12
col namespace for a10
col version for a22
col comments for a80
SELECT TO_CHAR(action_time, 'YYYY-MM-DD HH24:MI') AS FECHA
      ,action
      ,namespace
      ,version
      ,comments
--    ,bundle_series
  FROM sys.registry$history
 ORDER by action_time;
```

## Rollback

```bash
[grid@clbdvnet01 35642822]$ crsctl start has
CRS-6706: Oracle Clusterware Release patch level ('3293466898') does not match Software patch level ('724960844'). Oracle Clusterware cannot be started.
CRS-4000: Command Start failed, or completed with errors.
```

```bash
# Cluster
/oracle/app/product/19c/grid/crs/install/rootcrs.sh -prepatch
/oracle/app/product/19c/grid/crs/install/rootcrs.sh -postpatch

# Standalone
/oracle/app/product/19c/grid/crs/install/roothas.sh -unlock
/oracle/app/product/19c/grid/crs/install/roothas.sh -prepatch
/oracle/app/product/19c/grid/crs/install/roothas.sh -postpatch
```

```bash
opatchauto rollback /oracle/instaladores/parches/35642822 -oh /oracle/app/product/19c/grid
opatchauto rollback /oracle/instaladores/parches/35742441/35642822 -oh /oracle/app/product/19c/grid

/oracle/app/oracle/product/19c/db1/OPatch/opatchauto rollback /oracle/instaladores/parches/35742441/35642822 -oh /oracle/app/oracle/product/19c/db1/

/oracle/app/oracle/product/19c/db1/OPatch/opatchauto rollback /oracle/instaladores/parches/35742441/35642822 -oh /oracle/app/product/19c/grid
```
