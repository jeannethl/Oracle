--Crear la instancia manual.
    oracle@sun31q:/dbs$ vi initPAGOFP.ora
    
    *.audit_file_dest='/oracle/app/oracle/admin/PAGOFP/adump'
    *.audit_trail='db'
    *.compatible='11.2.0.0.0'
    *.control_files='+DG_REDO01/pagofp/controlfile/current.256.1193911785','+DG_REDO02/pagofp/controlfile/current.256.1193911785'
    *.db_block_size=8192
    *.db_create_file_dest='+DATA_PAGOFP'
    *.db_create_online_log_dest_1='+DG_REDO01'
    *.db_create_online_log_dest_2='+DG_REDO02'
    *.db_domain='BANVENEZ.CORP'
    *.db_name='PAGOFP'
    *.diagnostic_dest='/oracle/app/oracle'
    *.dispatchers='(PROTOCOL=TCP) (SERVICE=PAGOFPXDB)'
    ####*.local_listener='LISTENER_PAGOFP'
    *.open_cursors=300
    *.pga_aggregate_target=536870912
    *.processes=500
    *.remote_login_passwordfile='EXCLUSIVE'
    *.sessions=555
    *.sga_target=2147483648
    *.undo_tablespace='UNDOTBS1'
--- Se comenta previamente los controlfile.
-- Guardar y cerrar ---

--Crear carpeta del adump, auditoria
mkdir -p /oracle/app/oracle/admin/PAGOFP/adump

--Iniciar la BD en nomount

startup nomount pfile='/oracle/app/oracle/product/11.2.0/db_1/dbs/initRELBDVD.ora';

--Conectar a RMAN (catalogo)

    rman target / rcvcat rmanq/rmanexport@rman
    rman target / rcvcat rman/rmanexport@rman
    rman target / rcvcat rmand/rmanexport@rman

--Setear el DBID (identificarlo previamente).
--Si el servidor esta completamente inaccesible se debe de buscar el DBID en el servidor de RMAN
--Para identificarlo:
        select * from rmanp.rc_database; (Cambiar el esquema segun corresponda)
        select * from rman.rc_database WHERE NAME LIKE '%TERFIN%';
--Para setearlo ya en el catalogo de RMAN
        set dbid 607650238

--Validar Datafile a Restaurar

RMAN> report schema;
-- NOTA: Esta procedimiento es necesario, para conocer el nombre que poseeia el DISKGROUP, y por consecuente 
-- crear los diskgroups con el mismo nombre que aparecen en el catalogo, especialmente el de DATA. 
--Buscar backups en fecha especifica solo si es necesario verificar que las piezas esten disponibles o en cinta
RMAN> list backup of database completed between "to_date('01/06/2019','DD/MM/YYYY')" and "to_date('30/11/2019','DD/MM/YYYY')";

list backup of database completed between "to_date('06/02/2020','DD/MM/YYYY')" and "to_date('30/03/2020','DD/MM/YYYY')";

--EJEMPLO BD CYCLOPSQ
/*
List of Permanent Datafiles
        ===========================
        File Size(MB) Tablespace           RB segs Datafile Name
        ---- -------- -------------------- ------- ------------------------
        1    4096     SYSTEM               YES     +DG_DATA_CYCLOPSQ/cyclopsq/datafile/system.256.831994039
        2    2048     SYSAUX               NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/sysaux.257.831994039
        3    8192     UNDOTBS1             YES     +DG_DATA_CYCLOPSQ/cyclopsq/datafile/undotbs1.258.831994039
        4    8        USERS                NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/users.259.831994039
        5    30720    UNDOTBS2             YES     +DG_DATA_CYCLOPSQ/cyclopsq/datafile/undotbs2.261.831994393
        6    10240    DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.275.832428793
        7    10240    DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.269.832428871
        8    10240    DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.266.832428935
        9    10240    DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.274.832428999
        10   10240    DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.273.832429081
        11   1024     DATA01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_log.272.832429231
        12   1024     DATA01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_log.271.832429333
        13   1024     DATA01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_log.270.832429425
        14   1024     DATA01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_log.268.832429529
        15   1024     DATA01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_log.267.832429621
        16   1024     DATA01_CYCLOPS_LICENSING NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_licensing.265.832435381
        17   2048     INDX01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity.264.832440125
        18   2048     INDX01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity.263.832440195
        19   2048     INDX01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity.276.832440273
        20   2048     INDX01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity.277.832440359
        21   2048     INDX01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity.278.832440447
        22   1024     INDX01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_log.279.832440587
        23   1024     INDX01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_log.280.832440645
        24   1024     INDX01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_log.281.832440707
        25   1024     INDX01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_log.282.832440763
        26   1024     INDX01_CYCLOPS_IDENTITY_LOG NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_log.283.832440817
        27   1024     DATA01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_temp.284.832761563
        28   1024     DATA01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_temp.285.832761657
        29   1024     DATA01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_temp.286.832761779
        30   1024     DATA01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity_temp.287.832761867
        31   1024     INDX01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_temp.288.832762077
        32   1024     INDX01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_temp.289.832762163
        33   1024     INDX01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_temp.290.832762293
        34   1024     INDX01_CYCLOPS_IDENTITY_TEMP NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/indx01_cyclops_identity_temp.291.832762387
        35   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.292.833040441
        36   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.293.833040567
        37   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.294.833062899
        38   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.295.833063427
        39   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.296.833064099
        40   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.297.833064735
        41   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.298.833065153
        42   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.299.833154363
        43   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.300.833154459
        44   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.301.833154553
        45   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.302.833212451
        46   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.303.833212703
        47   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.304.833284807
        48   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.305.833285003
        49   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.306.833285191
        50   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.307.833286465
        51   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.308.833286665
        52   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.309.833286859
        53   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.310.833287073
        54   8192     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.311.833287293
        55   2000     CI_IDENTITY          NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/cidata1.dbf
        56   200      CI_IDENTITY_INDEX    NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/ciindex1.dbf
        57   2000     BIOPOS               NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/biopos.314.920833799
        58   2000     BIOPOSLOG            NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/bioposlog.315.920833885
        59   2000     IDENTITYBIOPOS       NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/identitybiopos.316.920834315
        60   2000     IDENTITYBIOPOSLOG    NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/identitybioposlog.317.920834377
        61   30720    UNDOTBS2             YES     +DG_DATA_CYCLOPSQ/cyclopsq/datafile/undotbs2.318.1080631119
        62   7168     UNDOTBS2             YES     +DG_DATA_CYCLOPSQ/cyclopsq/datafile/undotbs2.319.1080680657
        63   5000     DATA01_CYCLOPS_IDENTITY NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data01_cyclops_identity.320.1117792137
        64   3072     DATA_IDENTITY_LOG    NO      +DG_DATA_CYCLOPSQ/cyclopsq/datafile/data_identity_log.321.1173780509
*/


---Restore los controlfile
RUN
{
    allocate channel ch1 device type sbt_tape ;
    SET until time "to_date('10-OCT-2024 00:00:00','dd-mm-yyyy hh24:mi:ss')";
    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=PAGOFP_BOVEDA_MENSUAL,NSR_CLIENT=sun1330p)';
    RESTORE controlfile;
    release channel ch1;
}


RUN
{
    allocate channel ch1 device type sbt_tape ;
    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=TAG20250527T011124,NSR_CLIENT=bdvsun01)';
    RESTORE controlfile;
    release channel ch1;
}

--Proceso de restore del control file
allocated channel: ch1
channel ch1: SID=3759 device type=SBT_TAPE
channel ch1: NMDA Oracle v19.2.1.3

executing command: SET until clause

sent command to channel: ch1

Starting restore at 11-MAR-25

new media label is "BO4787L9" for piece "c-4272745383-20241005-00"
channel ch1: starting datafile backup set restore
channel ch1: restoring control file
channel ch1: reading from backup piece c-4272745383-20241005-00
channel ch1: piece handle=c-4272745383-20241005-00 tag=TAG20241005T144550
channel ch1: restored backup piece 1
channel ch1: restore complete, elapsed time: 00:04:16
output file name=+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482665
output file name=+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482685
Finished restore at 11-MAR-25

--Cambiar los control file por los que se restauraron
*.audit_file_dest='/oracle/app/oracle12/admin/PAGOFP/adump'
*.audit_trail='db'
*.compatible='12.2.0'
*.control_files='+DG_REDO01_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482665','+DG_REDO02_PAGOFP/PAGOFP/CONTROLFILE/current.258.1195482685' <---------- colocar en el ini de la base de datos de destino los control file que acabamos de restaurar
*.cursor_sharing='FORCE'
*.db_block_size=8192
PAGOFP.db_cache_advice='ON'
*.db_create_file_dest='+DG_DATA_PAGOFP'
*.db_create_online_log_dest_1='+DG_REDO01_PAGOFP'
*.db_create_online_log_dest_2='+DG_REDO02_PAGOFP'
*.db_files=1024
*.db_name='PAGOFP'
*.db_recovery_file_dest='+FRA'
*.db_recovery_file_dest_size=322122547200
*.diagnostic_dest='/oracle/app/oracle12'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=PAGOFPXDB)'
*.enable_ddl_logging=TRUE
###*.local_listener='LISTENER_PAGOFP'
*.log_archive_dest_1='LOCATION=+FRA'
*.log_archive_format='%t_%s_%r.dbf'
*.log_archive_max_processes=30
*.nls_language='AMERICAN'
*.nls_territory='AMERICA'
*.open_cursors=500
*.parallel_degree_policy='AUTO'
*.parallel_min_time_threshold='5'
*.pga_aggregate_limit=0
*.pga_aggregate_target=53687091200
*.processes=10000
*.remote_login_passwordfile='EXCLUSIVE'
*.session_cached_cursors=1200
*.sessions=3147
*.sga_max_size=40687091200
*.sga_target=10687091200
*.statistics_level='ALL'
PAGOFP.timed_os_statistics=60
PAGOFP.timed_statistics=TRUE
*.transactions=3169
*.undo_tablespace='UNDOTBS1'

--Colocar la BD en estado mount con la nueva modificacion en el init
startup mount pfile='/oracle/app/oracle12/product/12.2.0/db_1/dbs/initPAGOFP.ora';

--Restaurar acrchivelog, si la base de datos esta en modo no archvive saltarse este paso y el de restaurar data, restaure con los comandos modo noarchivelog.
--Ver la secuencia con LIST ARCHIVELOG ALL; 

--Correr en segundo plano cualquiera de los restore, cualquier comando de RMAN que se requiera correr en segundo plano simplemente se crea este archivo y se ejecuta
nohup rman rcvcat rmanp/rmanexport@RMAN12 target / cmdfile=archivo.cmd log=archivo.log &

RUN
{
    allocate channel ch1 device type sbt_tape ;
    allocate channel ch2 device type sbt_tape ;
    allocate channel ch3 device type sbt_tape ;
    allocate channel ch4 device type sbt_tape ;
    SET until time "to_date('10-OCT-2024 00:00:00','dd-mm-yyyy hh24:mi:ss')";
    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=PAGOFP_BOVEDA_MENSUAL,NSR_CLIENT=sun1330p)';
    restore archivelog from logseq=70608 until logseq=71000 thread=1;
    release channel ch1 ;
    release channel ch2 ;
    release channel ch3 ;
    release channel ch4 ;
}
 
--Restore de DATA

RUN
{
    allocate channel ch1 device type sbt_tape ;
    allocate channel ch2 device type sbt_tape ;
    allocate channel ch3 device type sbt_tape ;
    allocate channel ch4 device type sbt_tape ;
    SET until time "to_date('10-OCT-2024 00:00:00','dd-mm-yyyy hh24:mi:ss')";
    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=PAGOFP_BOVEDA_MENSUAL,NSR_CLIENT=sun1330p)';
    RESTORE database ;
    switch datafile all;
    RECOVER DATABASE USING BACKUP CONTROLFILE UNTIL CANCEL;
    release channel ch1 ;
    release channel ch2 ;
    release channel ch3 ;
    release channel ch4 ;
}

--Ya en SQL
alter database open resetlogs;




---Restore de data no archivelog

RUN
{
    allocate channel ch1 device type sbt_tape ;
    allocate channel ch2 device type sbt_tape ;
    allocate channel ch3 device type sbt_tape ;
    allocate channel ch4 device type sbt_tape ;
    SET until time "to_date('10-OCT-2024 00:00:00','dd-mm-yyyy hh24:mi:ss')";
    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=PAGOFP_BOVEDA_MENSUAL,NSR_CLIENT=sun1330p)';
    RESTORE database ;
    switch datafile all;
    release channel ch1 ;
    release channel ch2 ;
    release channel ch3 ;
    release channel ch4 ;
}

--EN SQL
recover database noredo;
alter database open resetlogs;
--Si da error y vez que la BD tiene versiones diferentes de oracle utilizar upgrade.
startup upgrade

--Ejecute el script de precomprobación antes de la actualización y solucione los problemas.

@$ORACLE_HOME/rdbms/admin/utlu112i.sql

--Ejecute el script de desactualización (consulte upgrade.log)

@$ORACLE_HOME/rdbms/admin/catupgrd.sql

--Para comprobar la actualización (consulte check_upgrade.log)

@$ORACLE_HOME/rdbms/admin/utlu112s.sql

--Ejecute el siguiente script y la base de datos no necesita estar en modo de actualización.

@$ORACLE_HOME/rdbms/admin/catuppst.sql

--Recompilar todos los objetos no válidos después de la actualización.

@$ORACLE_HOME/rdbms/admin/utlrp.sql --Verificar componentes de la base de datos:

col action_time for a30
col BUNDLE_SERIES for a15
col NAMESPACE for a10
col comments for a30
select * from dba_registry_history;


col comp_id for a10
col comp_name for a40
col version for a12
col status for a12
select comp_id, comp_name, version, status from dba_registry;

--Reiniciar la BBDD
shutdown immediate;
startup;


---Luego crear los TNSNAMES 

 SAMFQ =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = sun2204q)(PORT = 1560))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = SAMFQ.BANVENQA.COM)
        )
      )

--Agregar el string de conexión a LOCAL_LISTENER
        
ALTER SYSTEM SET local_listener='(ADDRESS=(PROTOCOL=tcp)(HOST=sun2204q.banvenqa.com)(PORT=1560))' SCOPE=BOTH;
SHUTDOWN IMMEDIATE;
STARTUP;
SHOW PARAMETER SPFILE;
create spfile from pfile='/oracle/app/oracle/product/11.2.0/dbhome_1/dbs/initSAMFQ.ora';


--Tambien puedes crear listener y modificarlo en el init

*.local_listener='LISTENER_SAMFQ' --y PROCEDER A CREAR EL SPFILE
create spfile from pfile='/oracle/app/oracle/product/11.2.0/dbhome_1/dbs/initSAMFQ.ora';



