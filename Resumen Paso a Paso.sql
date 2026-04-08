Migracion:
--editar los nombres de los archivos

***************************************************************************************************************
***************************************************************************************************************
*Monitoreo --Ambos Servidores

Abrir una ventana para cada monitoreo.
*Log Base de Datos

*vmstat 5 1000000

*while true; do iostat -d -x 2 2 | sort -n -k 11; sleep 5; echo ------- ; done

*Operaciones Largas
cd /Migracion3/TRZS/scripts/Monitoreo
sqlplus / as sysdba @show_long_operations

*Status del JOB

***************************************************************************************************************
***************************************************************************************************************

*servidor sun1120p
--cd /Migracion3/TRZS/scripts/Export

01_parfile_expdp_trzsp_full.sql

FULL
nohup expdp system/bdv23ccs2 parfile=01_parfile_expdp_trzsp_full.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_FULL_01


DOEREXTMSG
nohup expdp system/bdv23ccs2 parfile=02_parfile_expdp_trzsp_dem.par &

expdp system/bdv23ccs2 ATTACH=SYS_EXPORT_TABLE_01



***Mover los archivos .dmp generados a sus respectivas carpetas y dar permisos 777 a cada una

***************************************************************************************************************
***************************************************************************************************************


*servidor 172.27.70.66


Sacar DDL_INDEX  --(En el control de cambio este paso ya debe estar realizado)

Indices
*full
nohup impdp system/oracle1 parfile=parfile_extract_ddl_index.par &

impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01

*doer
nohup impdp system/oracle1 parfile=parfile_extract_ddl_index_dem.par &

impdp system/oracle1 ATTACH=SYS_SQL_FILE_FULL_01

Modificar los archivos obtenidos

******
*Import Metadata
Recordar modificar la fecha del .dmp en todos los archivos
20240925
--cd /Migracion3/TRZS/scripts/Import
FULL
nohup impdp system/oracle1 parfile=03_parfile_imp_metadata.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


DOEREXTMSG
nohup impdp system/oracle1 parfile=04_parfile_imp_metadata_dem.par &
impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


*Deshabilitar y crear triggers
--cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG
>SQL

@05_disable_trigger.sql
@06_create_dml_parallel_trigger.sql


*Import Data
--cd /Migracion3/TRZS/scripts/Import
FULL
nohup impdp system/oracle1 parfile=07_impdp_data_full.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


DOEREXTMSG
nohup impdp system/oracle1 parfile=08_impdp_data_dem.par &

impdp system/oracle1 ATTACH=SYS_IMPORT_FULL_01


--cd /Migracion3/TRZS/scripts/IDX_CONST_TRGG

*Habilita trigger
>SQL

@09_enable_trigger.sql

--Ya para este punto se sacaron y dividieron en distintos archivos los indx y const 
--por eso se ejecutan directamente los .sh para que salgan en paralelo.

bash

./10_ddl_indexes_lotes.sh
./11_ddl_constraints_lotes.sh


--/Migracion3/TRZS/scripts/OBJETOS_INVALIDOS

>SQL   --Verificar si este seria el orden

@12_homologacion_permisologia.sql

@13_verificar_objetos_invalidos.sql

@14_compilar_objetos_invalidos.sql

@15_verificar_objetos_invalidos.sql



/Migracion3/TRZS/scripts

@16_validar_usuarios.sql

@17_comparar_tbs.sql



