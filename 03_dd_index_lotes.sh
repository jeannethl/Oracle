03_ddl_index_lotes.sh

#!/bin/bash
#. ~/.bash_profile_DCSP
. ~/.bash_profile_TRZSP


LOG_DIR=/Migracion3/TRZS/scripts/IDX_CONST_TRGG/IDX_LOG

sqlplus / as sysdba @ddl_index_trzsp_full_1.sql > ${LOG_DIR}/ddl_index_trzsp_full_01.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_2.sql > ${LOG_DIR}/ddl_index_trzsp_full_02.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_3.sql > ${LOG_DIR}/ddl_index_trzsp_full_03.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_4.sql > ${LOG_DIR}/ddl_index_trzsp_full_04.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_5.sql > ${LOG_DIR}/ddl_index_trzsp_full_05.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_6.sql > ${LOG_DIR}/ddl_index_trzsp_full_06.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_7.sql > ${LOG_DIR}/ddl_index_trzsp_full_07.log &;
sqlplus / as sysdba @ddl_index_trzsp_full_8.sql > ${LOG_DIR}/ddl_index_trzsp_full_08.log &;








