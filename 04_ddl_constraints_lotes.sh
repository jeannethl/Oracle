#!/bin/bash
#. ~/.bash_profile_DCSP
. ~/.bash_profile_TRZSP


LOG_DIR=/Migracion3/TRZS/scripts/IDX_CONST_TRGG/CONST_LOG

sqlplus / as sysdba @ddl_constraint_trzsp_full.sql > ${LOG_DIR}/ddl_constraint_trzsp_full_01.log &;
sqlplus / as sysdba @ddl_constraint_trzsp_dem.sql > ${LOG_DIR}/ddl_constraint_trzsp_full_02.log &;
sqlplus / as sysdba @ddl_constraints_faltantes_C.sql > ${LOG_DIR}/ddl_constraint_trzsp_full_03.log &;
sqlplus / as sysdba @ddl_constraints_faltantes_U.sql > ${LOG_DIR}/ddl_constraint_trzsp_full_04.log &;

