#!/bin/bash

export ORACLE_BASE=/oracle/app/oracle12
export ORACLE_HOME=/oracle/app/oracle12/product/12.2.0/db_1
export GRID_HOME=/oracle/app/grid/product/12.2.0/grid
export ORACLE_SID=CCENLNP1
export ORACLE_PATH=$HOME/scripts
export PATH=$ORACLE_HOME/bin:$GRID_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

expdp \"/ as sysdba\" tables=CCENLNP.CCL_PAY_TRANSACTION:P_MES2 directory=EXPORT dumpfile=CCL_PAY_TRANSACTION_P_MES2_%U.dmp logfile=export_CCL_PAY_TRANSACTION_P_MES2.log EXCLUDE=STATISTICS PARALLEL=4 CLUSTER=N COMPRESSION=ALL

/export/home/oracle12/exportdump/increment.sh
