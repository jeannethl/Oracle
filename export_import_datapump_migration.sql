# Migracion usando export/import tunning <!-- omit in toc -->

Se usa metada y demas para hacer la actividad

## Index <!-- omit in toc -->

- [Base de Datos Origen](#base-de-datos-origen)
  - [1. Verificaciones previas](#1-verificaciones-previas)
  - [1.1 Contar con NFS entre el origen y destino](#11-contar-con-nfs-entre-el-origen-y-destino)
    - [1.2. No existan jobs automaticos a ejecutarse](#12-no-existan-jobs-automaticos-a-ejecutarse)
    - [1.3. No existan backups de rman RUNNING](#13-no-existan-backups-de-rman-running)
  - [2. Creacion del directory en donde se realiza export (origen)](#2-creacion-del-directory-en-donde-se-realiza-export-origen)
  - [3. Verificar CPU del servidor](#3-verificar-cpu-del-servidor)
    - [3.1. Verificar el parametro `max_datapump_parallel_per_job`](#31-verificar-el-parametro-max_datapump_parallel_per_job)
    - [3.2. Modificar parametro `max_datapump_parallel_per_job`](#32-modificar-parametro-max_datapump_parallel_per_job)
  - [4. Creacion del parfile para export full](#4-creacion-del-parfile-para-export-full)
    - [4.1. NFS en disco Local](#41-nfs-en-disco-local)
    - [4.2. Import metadata MOVEMENT\_HIST](#42-import-metadata-movement_hist)
  - [5. Creacion del parfile para extraccion de DDL de los indices](#5-creacion-del-parfile-para-extraccion-de-ddl-de-los-indices)
  - [6. Creacion del parfile para extraccion de DDL de los contraint](#6-creacion-del-parfile-para-extraccion-de-ddl-de-los-contraint)
  - [7. Ejecutar export full](#7-ejecutar-export-full)
    - [7.1 Monitoreo long operation](#71-monitoreo-long-operation)
  - [8. Ejecutar impdp para extraccion de DDL (index y constraint)](#8-ejecutar-impdp-para-extraccion-de-ddl-index-y-constraint)
  - [10. Generar DDL de los tablespace con nuestro estandar](#10-generar-ddl-de-los-tablespace-con-nuestro-estandar)
  - [11. Ver trigger](#11-ver-trigger)
  - [12. Cambiar permiso 777 a todos los archivos DMP](#12-cambiar-permiso-777-a-todos-los-archivos-dmp)
- [BASE DE DATOS DESTINO](#base-de-datos-destino)
  - [1. Crear los tablespace](#1-crear-los-tablespace)
  - [2. Crear directory para realizar import usando el NFS](#2-crear-directory-para-realizar-import-usando-el-nfs)
  - [6. Asignar mas espacio al TEMP](#6-asignar-mas-espacio-al-temp)
  - [3. Modificar parametro `max_datapump_parallel_per_job`](#3-modificar-parametro-max_datapump_parallel_per_job)
  - [4. Realizar backup full a disco](#4-realizar-backup-full-a-disco)
    - [4.1. Crear archivo de backup `.cmd`](#41-crear-archivo-de-backup-cmd)
    - [4.2. Crear script backup `.sh`](#42-crear-script-backup-sh)
    - [4.3. Ejecutar script backup](#43-ejecutar-script-backup)
  - [5. Crear parfile para import de METADATA](#5-crear-parfile-para-import-de-metadata)
    - [5.1. Import METADATA DCSP](#51-import-metadata-dcsp)
    - [5.2. Import tabla MOVEMENT\_HIST](#52-import-tabla-movement_hist)
  - [6. crear parfile para import de DATA](#6-crear-parfile-para-import-de-data)
  - [7. Set de cluster\_database en FALSE](#7-set-de-cluster_database-en-false)
  - [8. Bajar base de datos](#8-bajar-base-de-datos)
  - [9. Subir instancia](#9-subir-instancia)
  - [BAJAR LISTENER NODO1](#bajar-listener-nodo1)
  - [10. Import de metadata](#10-import-de-metadata)
  - [11. Desactivar triggers](#11-desactivar-triggers)
  - [12. Import de data](#12-import-de-data)
    - [12.1. Monitoting long operation](#121-monitoting-long-operation)
  - [13. Activar triggers](#13-activar-triggers)
  - [14. Crear Index](#14-crear-index)
  - [15. crear constraint](#15-crear-constraint)
  - [16. procedures faltantes](#16-procedures-faltantes)
  - [17. resolver objetos invalidos y esquema SYSMAN y APEX\_030200](#17-resolver-objetos-invalidos-y-esquema-sysman-y-apex_030200)
    - [17.1. Create DBLINK](#171-create-dblink)
    - [17.2. Check objects faltantes](#172-check-objects-faltantes)
    - [17.1. DCSP](#171-dcsp)
  - [18. Compilar todos los objetos invalidos](#18-compilar-todos-los-objetos-invalidos)
    - [19. Validar cantidad de objetos](#19-validar-cantidad-de-objetos)
  - [20. estadisticas de manejador](#20-estadisticas-de-manejador)
  - [21. estadisticas de esquema migrado](#21-estadisticas-de-esquema-migrado)
  - [22. Create job for update statictis](#22-create-job-for-update-statictis)
  - [23. Cambiar parametro CLUSTER\_DATABASE](#23-cambiar-parametro-cluster_database)
  - [24. Reiniciar BD como cluster](#24-reiniciar-bd-como-cluster)
  - [24. Verificar servicios de BD en cluster](#24-verificar-servicios-de-bd-en-cluster)
  - [25. Check dba\_registry](#25-check-dba_registry)
- [BORRADO DE AMBIENTE PARA INICIAR PRUEBAS NUEVAMENTE](#borrado-de-ambiente-para-iniciar-pruebas-nuevamente)
  - [1. Borrar archivos desde GRID](#1-borrar-archivos-desde-grid)
  - [2. Restaurar backup por rman del directorio /exportdb/DCSP/backup\_rman](#2-restaurar-backup-por-rman-del-directorio-exportdbdcspbackup_rman)
  - [2.1 Iniciar BD en NOMOUNT](#21-iniciar-bd-en-nomount)
  - [2.2. Restore controlfile](#22-restore-controlfile)
  - [2.3. Restore datafiles](#23-restore-datafiles)
  - [2.4. Open database](#24-open-database)
  - [3. Crear directory](#3-crear-directory)
  - [4. Cambiar parametro CLUSTER\_DATABASE](#4-cambiar-parametro-cluster_database)
  - [5. Reiniciar BD como cluster](#5-reiniciar-bd-como-cluster)
  - [6. Verificar servicios de BD en cluster](#6-verificar-servicios-de-bd-en-cluster)

## Base de Datos Origen

MENSAJE DEL ALERT

Memory Notification: Library Cache Object loaded into SGA
Heap size 55605K exceeds notification threshold (51200K)

### 1. Verificaciones previas

### 1.1 Contar con NFS entre el origen y destino

```bash
df -k
```

#### 1.2. No existan jobs automaticos a ejecutarse

```sql
```

#### 1.3. No existan backups de rman RUNNING

```sql
```

Se deben hacer 2 pruebas una en cada destino de NFS, a fin de determinar cual es mas rapida.

### 2. Creacion del directory en donde se realiza export (origen)

```sql
SET LINE 400
SET PAGES 300
COL OWNER FORMAT A30
COL DIRECTORY_NAME FORMAT A30
COL DIRECTORY_PATH FORMAT A100
SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
/
```

```sql
CREATE DIRECTORY MIGRACION_FULL_V3 AS '/Migracion3/DCSP';
GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL_V3 TO SYSTEM;
```

### 3. Verificar CPU del servidor

En solaris:

```bash
psrinfo
psrinfo -pv
```

From Sqlplus:

```sql
show parameter cpu
```

#### 3.1. Verificar el parametro `max_datapump_parallel_per_job`

```sql
show parameter max_datapump_parallel_per_job
```

>NOTA: Si el servidor posee mas de 50 CPU, se debe modificar el parametro, ejecutar el siguiente paso

#### 3.2. Modificar parametro `max_datapump_parallel_per_job`

```sql
ALTER SYSTEM SET MAX_DATAPUMP_PARALLEL_PER_JOB=96;
```

### 4. Creacion del parfile para export full

#### 4.1. NFS en disco Local

```bash
cd /Migracion3/DCSP/scripts
```

```bash
cat <<EOF > parfile_expdp_full_DCSP.par
DIRECTORY=MIGRACION_FULL_V3
FULL=Y
LOGFILE=EXPDP_FULL_DCSP.LOG
DUMPFILE=EXP_FULL_DCSP%U.dmp
EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS
METRICS=Y
ACCESS_METHOD=DIRECT_PATH
EXCLUDE=TABLE:"IN ('MOVEMENT_HIST')"
PARALLEL=24
CLUSTER=N
EOF
```

#### 4.2. Import metadata MOVEMENT_HIST

```bash
export DATE=$(date +'%Y%m%d')
cat <<EOF > parfile_expdp_metadata_movement_hist_dcsp.par
DIRECTORY=MIGRACION_FULL_V3
LOGFILE=EXPDP_METADATA_MOVEMENT_HIST_DCSP_${DATE}.LOG
DUMPFILE=EXPDP_METADATA_MOVEMENT_HIST_DCSP%U.dmp
EXCLUDE=STATISTICS
METRICS=Y
ACCESS_METHOD=DIRECT_PATH
PARALLEL=5
TABLES=DCSP.MOVEMENT_HIST
CONTENT=METADATA_ONLY
CLUSTER=N
EOF
```

### 5. Creacion del parfile para extraccion de DDL de los indices

```bash
export DATE=$(date +'%Y%m%d')
cat <<EOF > parfile_extract_ddl_index.par
DIRECTORY=MIGRACION_FULL_V3
FULL=Y
LOGFILE=IMP_DLL_INDEX_DCSP_${DATE}.LOG
DUMPFILE=EXP_FULL_DCSP%U.dmp
SQLFILE=ddl_index_DCSP.sql
METRICS=Y
PARALLEL=24
INCLUDE=INDEX
CLUSTER=N
EOF
```

### 6. Creacion del parfile para extraccion de DDL de los contraint

```bash
export DATE=$(date +'%Y%m%d')
cat <<EOF > parfile_extract_ddl_constraint.par
DIRECTORY=MIGRACION_FULL_V3
FULL=Y
LOGFILE=IMP_DLL_CONSTRAINT_DCSP_${DATE}.LOG
DUMPFILE=EXP_FULL_DCSP%U.dmp
SQLFILE=ddl_constraint_DCSP.sql
METRICS=Y
PARALLEL=24
INCLUDE=CONSTRAINT
CLUSTER=N
EOF
```

>NOTA: Agregar el paralelismo de acuerdo a la cantidad de archivos que se correran en simultaneo de acuerdo a la cantidad de CPU, es decir, CPU/cant_files.sql

- Cambiar parametro LOGGING a NOLOGING para que no genere archive

```bash
sed -i 's/PARALLEL 1/PARALLEL 32/' ddl_index_DCSP.sql
sed -i 's/PARALLEL 1/PARALLEL 32/' ddl_index_DCSP.sql
sed -i 's/PARALLEL 1/PARALLEL 32/' ddl_index_DCSP.sql
```

### 7. Ejecutar export full

```bash
# TIME #2: 05:20:29 SIN FINALIZAR
# TIME #3: 29 min
cd /Migracion3/DCSP/scripts
>nohup.out
nohup expdp system/k3r3p4kup41 parfile=parfile_expdp_full_DCSP.par &

## METADATA
expdp system/k3r3p4kup41 parfile=parfile_expdp_metadata_movement_hist_dcsp.par &

## MONITOREO JOB
expdp system/k3r3p4kup41 ATTACH=SYS_EXPORT_FULL_01
```

```sql
SELECT 
  DISTINCT OBJECT_NAME,
  OBJECT_TYPE,
  COUNT(1)
FROM DBA_OBJECTS
WHERE OBJECT_NAME='MOVEMENT_HIST'
GROUP BY OBJECT_NAME, OBJECT_TYPE
/
```

#### 7.1 Monitoreo long operation

```bash
vi show_long_operation.sql
```

```sql
set lin 1000
col TARGET_DESC format a50
col percent format a8
col start_time format a22
col estimate_fin format a22
col opname format a40
col ch format a20
col broken format a4
col message format a89 
set pagesize 100
set timi on 
set time on 

SELECT gvl.sid,
   gvl.serial#,
   gvl.opname,
   gvl.target_desc,
   vs.client_info ch,
   gvl.message, gvl.context,gvl.SQL_ID,
   gvl.percent,
   gvl.sofar,
   gvl.totalwork,
   to_char(gvl.start_time,   'dd-mon-rrrr hh24:mi:ss') start_time,
   to_char(gvl.efin,   'dd-mon-rrrr hh24:mi:ss') estimate_fin
   ,gvl.minutos_ejecucion
   ,gvl.time_remaining
    ,gvl.time_remaining + gvl.minutos_ejecucion tiempo_total 
    ,case when gvl.sofar <> gvl.totalwork and gvl.last_update_time < sysdate-1/10000 then (
 SELECT ROUND(SUM(v.value     /1024/1024)/NVL((SELECT MIN(elapsed_seconds)
             FROM v$session_longops
             WHERE opname          LIKE 'RMAN: aggregate input'
               AND sofar           != TOTALWORK
               AND elapsed_seconds IS NOT NULL
        ),SUM(v.value     /1024/1024)),2)
  FROM gv$sesstat v, v$statname n, gv$session s
 WHERE v.statistic# = n.statistic#
   AND n.name       = 'physical write total bytes'
   AND v.sid        = s.sid
   AND v.inst_id    = s.inst_id
   AND s.program LIKE 'rman@%'
 GROUP BY n.name
 )
 else  aio.MB_PER_S  END MB_PER_S
 ,aio.LONG_WAIT_PCT
   ,case when gvl.sofar <> gvl.totalwork and gvl.last_update_time < sysdate-1/10000 then '*' else null end broken
 FROM
   (SELECT sid,
      serial#,
      opname,
      target_desc,
      sofar,
      totalwork,
      message, context,SQL_ID,
      to_char(CASE
              WHEN totalwork = 0 THEN 1
              ELSE sofar / totalwork
              END *100,    '990D00') percent,
      start_time,
      last_update_time,
      start_time +((elapsed_seconds + time_remaining) / 86400) efin
      ,elapsed_seconds/60 minutos_ejecucion
      ,time_remaining/60 time_remaining
    FROM Gv$session_longops
    ORDER BY  CASE
              WHEN sofar = totalwork
                 THEN 1
                 ELSE 0 END,
           efin DESC) gvl
   ,v$session vs
   ,(select sid,
 serial,
 100* sum (long_waits) / decode(sum (io_count),0,1) as "LONG_WAIT_PCT",
 sum (nvl(effective_bytes_per_second,0))/1024/1024 as "MB_PER_S"
 from v$backup_async_io
 group by sid, serial) aio
 WHERE gvl.sofar <> gvl.totalwork
 and  vs.sid = gvl.sid
 and vs.serial# = gvl.serial#
 and aio.sid (+)= vs.sid
 and aio.serial (+)= vs.serial#
 order by percent;
```

```bash
cd /Migracion3/DCSP/scripts
while true
do
date
sqlplus -S / as sysdba @show_long_operation.sql
sleep 10
done
```

### 8. Ejecutar impdp para extraccion de DDL (index y constraint)

```bash
cd /Migracion3/DCSP/scripts
impdp system/k3r3p4kup41 parfile=parfile_extract_ddl_index.par &

impdp system/k3r3p4kup41 parfile=parfile_extract_ddl_constraint.par &
```

### 10. Generar DDL de los tablespace con nuestro estandar

```sql
spool 01_ddl_tablespace.sql
SET SERVEROUTPUT ON
DECLARE v_name_tablespace   VARCHAR2(300);
        v_size              NUMBER;
        v_cant_datafile     NUMBER;
        v_sentence          VARCHAR2(1000);

    CURSOR cur_datafile IS
        SELECT TABLESPACE_NAME
        , SUM(BYTES/1024/1024/1024) SIZE_GB
        , CASE ROUND(SUM(BYTES/1024/1024/1024)/30, 0) 
            WHEN 0 THEN 1
            ELSE ROUND(SUM(BYTES/1024/1024/1024)/30, 0) END CANT_DATAFILE
        FROM  DBA_DATA_FILES
        WHERE TABLESPACE_NAME NOT IN ('SYSTEM',
        'SYSAUX',
        'UNDOTBS1',
        'UNDOTBS2',
        'UNDOTBS3',
        'TEMP',
        'USERS')
        GROUP BY TABLESPACE_NAME;
    row_cur_datafile cur_datafile%ROWTYPE;

BEGIN 
    OPEN cur_datafile;
    FETCH cur_datafile INTO row_cur_datafile;
    WHILE cur_datafile%FOUND
    LOOP
        v_name_tablespace   := row_cur_datafile.TABLESPACE_NAME;
        v_size              := row_cur_datafile.SIZE_GB;
        v_cant_datafile     := row_cur_datafile.CANT_DATAFILE-1;

        DBMS_OUTPUT.PUT_LINE('CREATE TABLESPACE ' || v_name_tablespace || ' ');
        DBMS_OUTPUT.PUT_LINE('DATAFILE ' || CHR(39) || '+DATA' || CHR(39) || ' SIZE 30G AUTOEXTEND OFF');
        DBMS_OUTPUT.PUT_LINE('EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO DEFAULT NOCOMPRESS;');
        DBMS_OUTPUT.PUT_LINE(CHR(10));

        WHILE v_cant_datafile > 0
        LOOP
            DBMS_OUTPUT.PUT_LINE('ALTER TABLESPACE ' || v_name_tablespace ||
                ' ADD DATAFILE ' || CHR(39) || '+DATA' || CHR(39) || ' SIZE 30G AUTOEXTEND OFF;');
            v_cant_datafile := v_cant_datafile-1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(CHR(10));
    FETCH cur_datafile INTO row_cur_datafile;
    END LOOP;
    CLOSE cur_datafile;
END;
/
spool off;
```

### 11. Ver trigger

```sql
SET LINE 240
SET PAGES 300
COL OWNER FOR A30
COL OBJECT_NAME FOR A35
COL OBJECT_TYPE FOR A15
COL STATUS FOR A10
SELECT 
  OWNER,
  OBJECT_NAME,
  OBJECT_TYPE,
  STATUS
FROM DBA_OBJECTS
WHERE
  OBJECT_TYPE='TRIGGER'
  AND
    OWNER='DCSP'
/
```

### 12. Cambiar permiso 777 a todos los archivos DMP

```bash
cd /Migracion3/DCSP
chmod 777 *.dmp
chmod 777 *.sql
```

## BASE DE DATOS DESTINO

### 1. Crear los tablespace

```bash
sqlplus / as sysdba @01_ddl_tablespace_DCSP.sql &
```

### 2. Crear directory para realizar import usando el NFS

```sql
SET LINE 400 PAGES 500
COL OWNER FORMAT A25
COL DIRECTORY_NAME FORMAT A30
COL DIRECTORY_PATH FORMAT A100
SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
/
```

```sql
CREATE OR REPLACE DIRECTORY MIGRACION_FULL_V3 AS '/Migracion3/DCSP';
GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL_V3 TO SYSTEM;
```

### 6. Asignar mas espacio al TEMP

sqlplus / as sysdba

```sql
set pages 999
set lines 400
col FILE_NAME format a75
select 
  d.TABLESPACE_NAME,
  d.FILE_NAME,
  d.BYTES/1024/1024 SIZE_MB,
  d.AUTOEXTENSIBLE,
  d.MAXBYTES/1024/1024 MAXSIZE_MB,
  d.INCREMENT_BY*(v.BLOCK_SIZE/1024)/1024 INCREMENT_BY_MB
from dba_temp_files d,
  v$tempfile v
where d.FILE_ID = v.FILE#
order by d.TABLESPACE_NAME, d.FILE_NAME;
```

```sql
--agregar 2 veces
ALTER TABLESPACE TEMP ADD TEMPFILE '+DATA_DCSP' SIZE 32767M AUTOEXTEND ON;
```

### 3. Modificar parametro `max_datapump_parallel_per_job`

```sql
SHOW PARAMETER MAX_DATAPUMP_PARALLEL_PER_JOB
```

```sql
ALTER SYSTEM SET MAX_DATAPUMP_PARALLEL_PER_JOB=100;
```

### 4. Realizar backup full a disco

```bash
cd /Migracion3/DCSP/scripts
```

#### 4.1. Crear archivo de backup `.cmd`

```bash
export DATE=$(date +'%Y%m%d')
export DIR_BACKUP=/exportdb/DCSP/backup_rman
export ORACLE_SID=DCSP1
cat <<EOF > backup_rman.cmd
run { 
  allocate channel d1 type disk; 
  allocate channel d2 type disk; 
  sql 'alter system archive log current'; 
  backup archivelog all
        filesperset 2
        tag RESPALDO_ARC_${ORACLE_SID}_${DATE}
        format '${DIR_BACKUP}/arch_%d_%u_%s';
  backup current controlfile
        tag RESPALDO_CTL_${ORACLE_SID}_${DATE}
        format '${DIR_BACKUP}/Control_%d_%u_%s';
  backup database
        filesperset 5
        tag RESPALDO_DBF_${ORACLE_SID}_${DATE}
        format '${DIR_BACKUP}/datafiles_%d_%u_%s';  
  sql 'alter system archive log current';
  backup archivelog all
        filesperset 2
        tag RESPALDO_ARC_${ORACLE_SID}_${DATE} 
        format '${DIR_BACKUP}/arch_%d_%u_%s';
  backup spfile 
        format '${DIR_BACKUP}/SPfile_%d_%u_%s' 
        tag RESPALDO_SPF_${ORACLE_SID}_${DATE}; 
  release channel d1; 
  release channel d2; 
  }
EOF
```

#### 4.2. Crear script backup `.sh`

```bash
cat <<EOF > backup_rman.sh
#!/bin/bash

ORACLE_SID=DCSP1
NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS'
SCRIPT_DIR=/Migracion3/DCSP/scripts
DIR_LOG=/exportdb/DCSP/logs
DATE=\$(date "+%Y%m%d_%H%M")


rman target / cmdfile=\${SCRIPT_DIR}/backup_rman.cmd LOG=\${DIR_LOG}/backup_full_online_\${DATE}.log APPEND using \${ORACLE_SID}
EOF
```

```bash
chmod 775 backup_rman.sh
```

#### 4.3. Ejecutar script backup

```bash
cd /Migracion3/DCSP/scripts
nohup ./backup_rman.sh &
```

### 5. Crear parfile para import de METADATA

#### 5.1. Import METADATA DCSP

```bash
export DATE=$(date +'%Y%m%d')
cat <<EOF > parfile_imp_metadata.par
DIRECTORY=MIGRACION_FULL_V3
FULL=Y
LOGFILE=IMP_METADATA_DCSP_${DATE}.LOG
DUMPFILE=EXP_FULL_DCSP%U.dmp
METRICS=Y
ACCESS_METHOD=DIRECT_PATH
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS,TABLESPACE
PARALLEL=24
CONTENT=METADATA_ONLY
LOGTIME=ALL
EOF
```

#### 5.2. Import tabla MOVEMENT_HIST

```bash
export DATE=$(date +'%Y%m%d')
cat <<EOF > parfile_imp_metadata_movement_hist.par
DIRECTORY=MIGRACION_FULL_V3
LOGFILE=IMP_METADATA_DCSP_MOVEMENT_HIST_${DATE}.LOG
DUMPFILE=EXPDP_METADATA_MOVEMENT_HIST_DCSP%U.dmp
METRICS=Y
ACCESS_METHOD=DIRECT_PATH
EXCLUDE=PROCACT_SYSTEM,STATISTICS,TABLESPACE
PARALLEL=24
CONTENT=METADATA_ONLY
LOGTIME=ALL
EOF
```

### 6. crear parfile para import de DATA

```bash
export DATE=$(date +'%Y%m%d')
cat <<EOF > parfile_imp_data.par
DIRECTORY=MIGRACION_FULL_V3
FULL=Y
LOGFILE=IMP_DATA_DCSP_${DATE}.LOG
DUMPFILE=EXP_FULL_DCSP%U.dmp
METRICS=YES
PARALLEL=24
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N
EOF
```

### 7. Set de cluster_database en FALSE

```bash
sqlplus / as sysdba
```

```sql
ALTER SYSTEM SET CLUSTER_DATABASE=FALSE SCOPE=SPFILE;
```

### 8. Bajar base de datos

```bash
srvctl status database -d DCSP
srvctl stop database -d DCSP
```

### 9. Subir instancia

```bash
srvctl start instance -d DCSP -i DCSP1
```

```bash
ALTER SYSTEM FLUSH SHARED_POOL;
```

### BAJAR LISTENER NODO1

```bash
srvctl stop listener -l LISTENER
```

### 10. Import de metadata

```bash
cd /Migracion3/DCSP/scripts

impdp SYSTEM/oracle1 VERSION=19.3.0.0.0 PARFILE=parfile_imp_metadata.par &

impdp SYSTEM/oracle1 VERSION=19.3.0.0.0 PARFILE=parfile_imp_metadata_movement_hist.par &
```

Errores presentados:

```bash
1. ORA-29371: pending area is not active
2. ORA-39358: Export dump file version 19.3.0.0.0 not compatible with target version 19.1.0.0.0
```

Solucion:

1. ORA-29370 And ORA-29371 When Trying To Create Plans And Consumer Groups (Doc ID 2244655.1)
2. Colocar el parametro `VERSION` para poder iniciar el comando del import

### 11. Desactivar triggers

```bash
sqlplus / as sysdba 
```

```sql
ALTER TRIGGER DCSP.BIOPAY_CURRENCY_ON_INSERT DISABLE;
ALTER TRIGGER DCSP.BIOPAY_SERVICE_ON_INSERT DISABLE;
```

### 12. Import de data

```bash
cd /Migracion3/DCSP/scripts
>nohup.out
nohup impdp SYSTEM/oracle1 VERSION=19.3.0.0.0 PARFILE=parfile_imp_data.par &

impdp SYSTEM/oracle1 VERSION=19.3.0.0.0 ATTACH=SYS_IMPORT_FULL_01
```

#### 12.1. Monitoting long operation

```bash
cd /Migracion3/DCSP/scripts
while true
do
date
sqlplus -S / as sysdba @show_long_operation.sql
sleep 20
done
```

### 13. Activar triggers

Una vez finalice la carga de datos

```sql
ALTER TRIGGER DCSP.BIOPAY_CURRENCY_ON_INSERT ENABLE;
ALTER TRIGGER DCSP.BIOPAY_SERVICE_ON_INSERT ENABLE;
```

### 14. Crear Index

Antes de crear el archivo por lote se debe correr el script tal como fue creado con las modificaciones de PARALLEL y NOLOGGING

```bash
sqlplus / as sysdba @ddl_index_DCSP.sql &
```

```bash
for num in {1..8}
do
touch ddl_index_lote_0$num.sql
done
```

```bash
cat <<EOF > execute_ddl_index.sh
#!/bin/bash
. ~/.bash_profile_DCSP

LOG_DIR=/Migracion3/DCSP/scripts/index/logs

sqlplus / as sysdba @ddl_index_lote_01.sql > \${LOG_DIR}/ddl_index_lote_01.log &
sqlplus / as sysdba @ddl_index_lote_02.sql > \${LOG_DIR}/ddl_index_lote_02.log &
sqlplus / as sysdba @ddl_index_lote_03.sql > \${LOG_DIR}/ddl_index_lote_03.log &
sqlplus / as sysdba @ddl_index_lote_04.sql > \${LOG_DIR}/ddl_index_lote_04.log &
sqlplus / as sysdba @ddl_index_lote_05.sql > \${LOG_DIR}/ddl_index_lote_05.log &
sqlplus / as sysdba @ddl_index_lote_06.sql > \${LOG_DIR}/ddl_index_lote_06.log &
sqlplus / as sysdba @ddl_index_lote_07.sql > \${LOG_DIR}/ddl_index_lote_07.log &
sqlplus / as sysdba @ddl_index_lote_08.sql > \${LOG_DIR}/ddl_index_lote_08.log &
EOF
```

```bash
chmod 775 execute_ddl_index.sh
```

```bash
cd /Migracion3/DCSP/scripts/index
>nohup.out
nohup ./execute_ddl_index.sh &
```

```bash
while true
do
ps -ef | grep -i sqlplus | grep -v grep
date
echo -e "\n"
sleep 5
done
```

### 15. crear constraint

Este script se corre para verificar los tiempos antes de dividir el proceso en partes

```bash
LOG_DIR=/Migracion3/DCSP/scripts/constraints/logs
sqlplus / as sysdba @ddl_constraint_DCSP.sql > ${LOG_DIR}/ddl_constraint_DCSP.log &
```

```bash
cat <<EOF > execute_ddl_constraint.sh
#!/bin/bash
. ~/.bash_profile_DCSP

LOG_DIR=/Migracion3/DCSP/scripts/constraints/logs

sqlplus / as sysdba @ddl_constraint_lote_01.sql > \${LOG_DIR}/ddl_constraint_lote_01.log &
sqlplus / as sysdba @ddl_constraint_lote_02.sql > \${LOG_DIR}/ddl_constraint_lote_02.log &
sqlplus / as sysdba @ddl_constraint_lote_03.sql > \${LOG_DIR}/ddl_constraint_lote_03.log &
EOF
```

```bash
chmod 775 execute_ddl_constraint.sh
```

```bash
cd /Migracion3/DCSP/scripts/constraints
>nohup.out
nohup ./execute_ddl_constraint.sh &
```

```bash
while true
do
ps -ef | grep -i sqlplus | grep -v grep
date
echo -e "\n"
sleep 5
done
```

### 16. procedures faltantes

```sql
SET LONG 200000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 10000000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
BEGIN
  DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
  DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/

spool /Migracion3/DCSP/scripts/procedures/procedures_faltantes.sql
select dbms_metadata.get_ddl('PROCEDURE', 'UPDATE_STATISTICS', 'SYS')  from dual;
spool off;
```

```bash
sqlplus / as sysdba @/Migracion3/DCSP/scripts/procedures/procedures_faltantes.sql
```

### 17. resolver objetos invalidos y esquema SYSMAN y APEX_030200

#### 17.1. Create DBLINK

```sql
CREATE DATABASE LINK "SYS_HUB.BANVENEZ.CORP" USING 'DCSP';
```

```sql
CREATE DATABASE LINK DCSP_ORIG_TEMP
 CONNECT TO SYSTEM
 IDENTIFIED BY "k3r3p4kup41"
 USING 'DCSP_ORIG';
```

#### 17.2. Check objects faltantes

Usar siempre que se hagan consultas usando el DBLINK

```sql
ALTER SESSION SET GLOBAL_NAMES=FALSE;
ALTER SYSTEM SET SERVICE_NAMES='DCSP';
```

```sql
SELECT value
FROM v$parameter
WHERE name = 'service_names';
```

```sql
select owner, object_type, object_name, status
from (
select owner, object_type, object_name, status
from dba_objects
where status ='INVALID'
minus
select owner, object_type, object_name, status
from dba_objects@DCSP_ORIG_TEMP
where status ='INVALID'
)
order by 1,2
/
```

```sql
set pages 300
col owner format a20
col OBJECT_TYPE format a50
col cantidad for 999,999,999
SELECT owner
, COUNT(1) "CANTIDAD"
, OBJECT_TYPE
FROM (
select owner
, COUNT(1) "CANTIDAD"
, OBJECT_TYPE
from dba_objects
-- where owner = 'DCSP'
group by OBJECT_TYPE,owner
MINUS
select owner
, COUNT(1) "CANTIDAD"
, OBJECT_TYPE
from dba_objects@DCSP_ORIG_TEMP
-- where owner = 'DCSP'
group by OBJECT_TYPE,owner
)
group by OBJECT_TYPE,owner
order by owner,"CANTIDAD",OBJECT_TYPE;
```

#### 17.1. DCSP

```sql
-- GRANT EXECUTE ON DBMS_CRYPTO TO DCSP;
GRANT EXECUTE ON DBMS_LOCK TO DCSP;
```

### 18. Compilar todos los objetos invalidos

```sql
@?/rdbms/admin/utlrp.sql
```

```sql
set linesize 500 pages 500
col owner format a30
col object_name format a50
col OBJECT_TYPE format a50
col status format a30
select OWNER
,OBJECT_NAME
,OBJECT_TYPE
,STATUS 
from dba_objects
where status = 'INVALID'
order by OWNER,OBJECT_TYPE,OBJECT_NAME
/
```

```sql
set linesize 500 pages 500
col owner format a30
col object_name format a50
col OBJECT_TYPE format a50
col status format a30
select OWNER
,OBJECT_NAME
,OBJECT_TYPE
,STATUS 
from dba_objects
where OBJECT_TYPE = 'INDEX'
AND OWNER = 'DCSP'
AND OBJECT_NAME NOT LIKE 'SYS_IL%'
order by OWNER,OBJECT_TYPE,OBJECT_NAME
/
```

```sql
set linesize 500 pages 500
col object_name format a50
select OBJECT_NAME
from dba_objects
where OBJECT_TYPE = 'INDEX'
AND OWNER = 'DCSP'
AND OBJECT_NAME NOT LIKE 'SYS_%'
order by OWNER,OBJECT_TYPE,OBJECT_NAME
/
```

```sql
set pages 300
col owner format a20
col OBJECT_TYPE format a50
col cantidad for 999,999,999
select owner
, COUNT(1) "CANTIDAD"
, OBJECT_TYPE
from dba_objects
where status = 'INVALID'
group by OBJECT_TYPE,owner
order by owner,"CANTIDAD",OBJECT_TYPE;
```

#### 19. Validar cantidad de objetos

```sql
set pages 300
col owner format a20
col OBJECT_TYPE format a50
col cantidad for 999,999,999
select owner
, COUNT(1) "CANTIDAD"
, OBJECT_TYPE
from dba_objects
-- where owner = 'DCSP'
group by OBJECT_TYPE,owner
order by owner,"CANTIDAD",OBJECT_TYPE
/
```

```bash
     1 JOB
     1 VIEW
     2 TRIGGER
     4 SEQUENCE
     6 PACKAGE
     6 PACKAGE BODY
    23 LOB
    29 TABLE
    70 PROCEDURE
    72 INDEX
 2,560 TABLE PARTITION
 2,664 TABLE SUBPARTITION
 4,524 LOB SUBPARTITION
 5,268 INDEX SUBPARTITION
 8,680 LOB PARTITION
 8,717 INDEX PARTITION
```

```sql
--54
SELECT COUNT(1)
FROM DBA_CONSTRAINTS 
WHERE OWNER='DCSP';
```

```sql
SET LINE 180 PAGES 500
COL OWNER FOR A15
COL CONSTRAINT_NAME FOR A30
COL CONSTRAINT_TYPE FOR A30
COL INDEX_NAME FOR A30
COL STATUS FOR A15
COL GENERATED FOR A25
SELECT
  OWNER,
  CONSTRAINT_NAME,
  CONSTRAINT_TYPE,
  -- INDEX_NAME,
  GENERATED,
  STATUS
FROM DBA_CONSTRAINTS
WHERE OWNER='DCSP'
ORDER BY CONSTRAINT_TYPE, CONSTRAINT_NAME;
```

```sql
SET LINE 180 PAGES 500
COL OWNER FOR A15
COL CONSTRAINT_NAME FOR A30
COL CONSTRAINT_TYPE FOR A30
COL INDEX_NAME FOR A30
COL STATUS FOR A15
COL GENERATED FOR A25
SELECT *
FROM (
SELECT
  OWNER,
  CONSTRAINT_NAME,
  CONSTRAINT_TYPE,
  -- INDEX_NAME,
  GENERATED,
  STATUS
FROM DBA_CONSTRAINTS@DCSP_ORIG_TEMP
WHERE OWNER='DCSP'
MINUS
SELECT
  OWNER,
  CONSTRAINT_NAME,
  CONSTRAINT_TYPE,
  -- INDEX_NAME,
  GENERATED,
  STATUS
FROM DBA_CONSTRAINTS
WHERE OWNER='DCSP'
)
ORDER BY CONSTRAINT_TYPE, CONSTRAINT_NAME;
```

```sql
-- 112
select count(1)
from dba_procedures 
where OWNER='DCSP';
```

### 20. estadisticas de manejador

3min

```sql
BEGIN
  DBMS_STATS.GATHER_SYSTEM_STATS;
  DBMS_STATS.GATHER_DICTIONARY_STATS(Degree=> 160);
  DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
END;
/
```

### 21. estadisticas de esquema migrado

5min a 7min

```sql
BEGIN
FOR t IN (SELECT OWNER, TABLE_NAME FROM DBA_TABLES WHERE OWNER ='DCSP')
  LOOP
    DBMS_STATS.GATHER_TABLE_STATS (ownname => t.OWNER, tabname => t.TABLE_NAME, estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, degree => 160, cascade => TRUE);
  END LOOP;
END;
/
```

### 22. Create job for update statictis

```sql
--CREAR JOB 
BEGIN
  DBMS_SCHEDULER.create_job (
    job_name        => 'STATISTICS_MOVEMENT',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'BEGIN SYS.UPDATE_STATISTICS; END;',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=WEEKLY; BYDAY=FRI; BYHOUR=23; BYMINUTE=45',
    enabled         => TRUE);
END;
/
```

### 23. Cambiar parametro CLUSTER_DATABASE

```sql
ALTER SYSTEM SET CLUSTER_DATABASE=TRUE SCOPE=SPFILE;
```

### 24. Reiniciar BD como cluster

```bash
srvctl status database -d DCSP

srvctl stop database -d DCSP && srvctl start database -d DCSP
```

### 24. Verificar servicios de BD en cluster

```bash
srvctl status database -d DCSP
```

### 25. Check dba_registry

```sql
SET TIMI ON
SET TIME ON
SET LINE 380
SET PAGESIZE 50
COL COMP_NAME FORMAT A50
COL STATUS FORMAT A10
SELECT 
  COMP_NAME
  , VERSION
  , VERSION_FULL
  , STATUS
FROM DBA_REGISTRY;
```

## BORRADO DE AMBIENTE PARA INICIAR PRUEBAS NUEVAMENTE

### 1. Borrar archivos desde GRID

```sql
ALTER SYSTEM SET CLUSTER_DATABASE=FALSE SCOPE=SPFILE;
```

```bash
srvctl stop database -d DCSP
```

Entrar a cada directorio y eliminar el contenido

Como usuario grid

```bash
asmcmd -p
```

```bash
cd +REDO01_DCSP/DCSP/ONLINELOG
cd +REDO02_DCSP/DCSP/ONLINELOG
cd +DATA_DCSP/DCSP/DATAFILE
cd +DATA_DCSP/DCSP/TEMPFILE
cd +FRA_DCSP/DCSP/ARCHIVELOG
cd +FRA_DCSP/DCSP/FLASHBACK
```

### 2. Restaurar backup por rman del directorio /exportdb/DCSP/backup_rman

### 2.1 Iniciar BD en NOMOUNT

```bash
srvctl start instance -d DCSP -i DCSP1 -o nomount
```

### 2.2. Restore controlfile

rman target /

```bash
run {
  restore controlfile from '/exportdb/DCSP/backup_rman/Control_DCSP_1g2vlcfv_48';
  alter database mount;
}
```

### 2.3. Restore datafiles

```bash
run {
  allocate channel d1 type disk; 
  allocate channel d2 type disk; 
  allocate channel d3 type disk; 
  allocate channel d4 type disk; 
  allocate channel d5 type disk; 
  allocate channel d6 type disk; 
  allocate channel d7 type disk; 
  allocate channel d8 type disk; 
  catalog start with '/exportdb/DCSP/backup_rman';
  restore database;
  recover database;
  release channel d1; 
  release channel d2; 
  release channel d3; 
  release channel d4; 
  release channel d5; 
  release channel d6; 
  release channel d7; 
  release channel d8; 
}
```

### 2.4. Open database

```sql
alter database open resetlogs;
```

### 3. Crear directory

```sql
SET LINE 400
COL OWNER FORMAT A25
COL DIRECTORY_NAME FORMAT A30
COL DIRECTORY_PATH FORMAT A100
SELECT OWNER, DIRECTORY_PATH, DIRECTORY_NAME FROM DBA_DIRECTORIES
/
```

```sql
CREATE OR REPLACE DIRECTORY MIGRACION_FULL_V3 AS '/Migracion3/DCSP';
GRANT READ,WRITE ON DIRECTORY MIGRACION_FULL_V3 TO SYSTEM;
```

### 4. Cambiar parametro CLUSTER_DATABASE

```sql
ALTER SYSTEM SET CLUSTER_DATABASE=TRUE SCOPE=SPFILE;

ALTER SYSTEM SET SERVICE_NAMES='DCSP';

ALTER SYSTEM RESET DB_DOMAIN;
```

### 5. Reiniciar BD como cluster

```bash
srvctl status database -d DCSP

srvctl stop database -d DCSP && srvctl start database -d DCSP
```

### 6. Verificar servicios de BD en cluster

```bash
srvctl status database -d DCSP
crsctl stat res -t
```
