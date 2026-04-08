export ORACLE_BASE=/oracle/app/grid
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0.4/grid
export ORACLE_SID=+ASM
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export PATH=$PATH:/usr/local/bin:/usr/sbin:/usr/bin:/usr/openwin/bin:/usr/ucb:$ORACLE_HOME/bin
export TEMP=/tmp
export TMPDIR=/tmp
export EDITOR=vim


$ORACLE_HOME/lib/sysliblist

-ldl -lm -lpthread -lnsl -lirc -lipgo -lsvml -laio


$ORACLE_HOME/bin/relink all/oracle/app/grid/product/11.2.0.4/grid/root.sh


cd /lib64
sudo ln -s libcap.so.2.48 libcap.so.1