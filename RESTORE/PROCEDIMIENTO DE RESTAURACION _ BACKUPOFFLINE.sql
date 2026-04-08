PROCEDIMIENTO DE RESTAURACION _ BACKUP-offline (De un server a otro)
#####################################################################

--- DBATEAM
--- Version 250202025

1) Crear la instancia a manopla.


    oracle@sun31q:/dbs$ vi initCYCLOPSQ.ora
    
    *.audit_file_dest='/oracle/app/oracle/admin/CYCLOPSQ/adump'
    *.audit_trail='db'
    *.compatible='11.2.0.0.0'
    *.control_files='+DG_REDO01/cyclopsq/controlfile/current.256.1193911785','+DG_REDO02/cyclopsq/controlfile/current.256.1193911785'
    *.db_block_size=8192
    *.db_create_file_dest='+DATA_CYCLOPSQ'
    *.db_create_online_log_dest_1='+DG_REDO01'
    *.db_create_online_log_dest_2='+DG_REDO02'
    *.db_domain='BANVENEZ.CORP'
    *.db_name='CYCLOPSQ'
    *.diagnostic_dest='/oracle/app/oracle'
    *.dispatchers='(PROTOCOL=TCP) (SERVICE=CYCLOPSQXDB)'
    ####*.local_listener='LISTENER_CYCLOPSQ'
    *.open_cursors=300
    *.pga_aggregate_target=536870912
    *.processes=500
    *.remote_login_passwordfile='EXCLUSIVE'
    *.sessions=555
    *.sga_target=2147483648
    *.undo_tablespace='UNDOTBS1'
   
   --- Se comenta previamente los controlfile.
   -- Guardar y cerrar ---

2) Conectar a RMAN (catalogo)

    rman target / rcvcat rmanq/rmanexport@rman

3) Setear el DBID (identificarlo previamente).

    Para identificarlo, se puede ver en el servidor de RMAN.

        select * from rmanq.rc_database; (Cambiar el esquema segun corresponda)


    set dbid 3331618000

4) Validar Datafile a Restaurar

    RMAN> report schema;

        -- NOTA: Esta procedimiento es necesario, para conocer el nombre que poseeia el DISKGROUP, y por consecuente 
        -- crear los diskgroups con el mismo nombre que aparecen en el catalogo.

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

        List of Temporary Files
        =======================
        File Size(MB) Tablespace           Maxsize(MB) Tempfile Name
        ---- -------- -------------------- ----------- --------------------
        1    10240    TEMP                 10240       +DG_DATA_CYCLOPSQ/cyclopsq/tempfile/temp.260.831994323

5) Iniciar la BD modo NOMOUNT.

    startup nomount;

6) Correr script de restauracion en RMAN. 

    6.1) Restauracion de ControlFile.

        run
        {
        allocate channel ch1 device type sbt_tape ;
        send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=CYCLOPSQ1_OFFLINE_FULL,NSR_CLIENT=sun11qz6n1)';
        RESTORE controlfile;
        release channel ch1;
        }


        --OUTPUT AL FINALIZAR EL RESTORE DE LOS CONTROLFILE
        channel ch1: starting datafile backup set restore
        channel ch1: restoring control file
        channel ch1: reading from backup piece c-3331618000-20250208-00
        channel ch1: piece handle=c-3331618000-20250208-00 tag=TAG20250208T223737
        channel ch1: restored backup piece 1
        channel ch1: restore complete, elapsed time: 00:03:25
        output file name=+DG_REDO01/cyclopsq/controlfile/current.256.1193911785
        output file name=+DG_REDO02/cyclopsq/controlfile/current.256.1193911785
        Finished restore at 24-FEB-25

        released channel: ch1


    -- Agregar los control en el INIT previamente creado (descomentar las lineas)


    6.2) Bajar la instancia:

        shutdown immediate;

    6.3) Subir la instancia a mount (Init ya debe estar modificado).

        startp mount;

7) Restaurar BBDD desde el catalogo

    RUN
    {
    allocate channel ch1 device type sbt_tape ;
    allocate channel ch2 device type sbt_tape ;
    allocate channel ch3 device type sbt_tape ;
    allocate channel ch4 device type sbt_tape ;
    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_DATA_VOLUME_POOL=CYCLOPSQ1_OFFLINE_FULL,NSR_CLIENT=sun11qz6n1)';
    RESTORE database ;
    release channel ch1 ;
    release channel ch2 ;
    release channel ch3 ;
    release channel ch4 ;
    }


    7.1) Recover database no redo
    
        recover database noredo;

8) Abrir la base de datos 

    alter database open resetlogs;


        NOTA: Si la version no es la misma (version oracle) es probable que indique este error luego del alter.


                --RMAN> alter database open resetlogs;
                --
                --RMAN-00571: ===========================================================
                --RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
                --RMAN-00571: ===========================================================
                --RMAN-03002: failure of alter db command at 02/24/2025 11:55:35
                --ORA-01092: ORACLE instance terminated. Disconnection forced
                --ORA-00704: bootstrap process failure
                --ORA-39700: database must be opened with UPGRADE option
                --Process ID: 26762
                --Session ID: 1 Serial number: 17
                --


        -- Ir a SQLPLUS y levantar la BD con opcion upgrade.

        startup upgrade;


        -- Correr los siguientes paquetes:

        [oracle@soyundba ~]$ sqlplus / as sysdba

        SQL> @?/rdbms/admin/catalog.sql;

        SQL> @?/rdbms/admin/catproc.sql;
        ******************************************************************************************

        Validaciones:

        select name,open_mode from v$database;
        select instance_name, status from v$instance;

        NAME      OPEN_MODE
        --------- --------------------
        CYCLOPSQ  READ WRITE

        INSTANCE_NAME    STATUS
        ---------------- ------------
        CYCLOPSQ         OPEN MIGRATE


        --https://soyundba.com/2024/04/17/ora-00704-bootstrap-process-failure-ora-39700-database-must-be-opened-with-upgrade-option/

9) Reiniciar la BBDD

    shutdown immediate;
    startup;


10) Modificación del string de conexión en el tnsname

    CYCLOSPQ =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = sun2204q)(PORT = 1560))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = CYCLOSPQ.BANVENQA.COM)
        )
      )

    10.1) Agregar el string de conexión a LOCAL_LISTENER
        
        ALTER SYSTEM SET local_listener='(ADDRESS=(PROTOCOL=tcp)(HOST=sun2204q.banvenqa.com)(PORT=1560))' SCOPE=BOTH;

        SHUTDOWN IMMEDIATE;
        STARTUP;

        SHOW PARAMETER SPFILE;
        create spfile from pfile='/oracle/app/oracle/product/11.2.0/dbhome_1/dbs/initSAMFQ.ora';