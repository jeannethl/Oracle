scp "C:\Users\NM42276\Downloads\RPM2\rpm\compat-libcap1-1.10-7.el7.x86_64.rpm" grid@172.27.88.78:/exportdb/rpm


scp "C:/Users/NM42276/Downloads/RPM2/rpm/compat-libcap1-1.10-7.el7.x86_64.rpm" grid@172.27.88.78:/exportdb/rpm


rpm -Uvh ksplice-uptrack-release.noarch.rpm
rpm -Uvh oracleasmlib-2.0.17-1.el8.x86_64.rpm
rpm -Uvh oracleasm-support-2.1.12-1.el8.x86_64.rpm
rpm -Uvh oracle-database-preinstall-19c-1.0-3.el7.x86_64.rpm

rpm -Uvh compat-libcap1-1.10-7.el7.x86_64.rpm
rpm -Uvh compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm


rpm -Uvh uptrack-1.2.80-0.el8.noarch.rpm
rpm -Uvh nmon-16p-5.el8.x86_64.rpm
rpm -Uvh htop-3.2.1-1.el8.x86_64.rpm


rpm -e ksplice-uptrack-release



mkdir -p /oracle/app/oraInventory
mkdir -p /oracle/app/grid
mkdir -p /oracle/app/grid/product/19c/grid
mkdir -p /oracle/app/oracle/product/11.2.0.4/db1
chown -R grid:oinstall /oracle/
chown -R oracle11:oinstall /oracle/app/oracle
chmod -R 775 /oracle/

useradd -u 54321 -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba,oper,asmoper,asmadmin oracle

----oracle11
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH


TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
ORACLE_HOSTNAME=plrmorabd01; export ORACLE_HOSTNAME
ORACLE_UNQNAME=RMAN; export ORACLE_UNQNAME
ORACLE_BASE=/oracle/app/oracle; export ORACLE_BASE
GRID_HOME=/oracle/app/grid/product/19c/grid; export GRID_HOME
DB_HOME=$ORACLE_BASE/product/11.2.0.4/db1; export DB_HOME
ORACLE_HOME=$DB_HOME; export ORACLE_HOME
ORACLE_SID=RMAN; export ORACLE_SID
ORACLE_TERM=xterm; export ORACLE_TERM
BASE_PATH=/usr/sbin:$PATH; export BASE_PATH
PATH=$PATH:/usr/local/bin:/usr/sbin:/usr/bin:/usr/openwin/bin:/usr/ucb:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE



----grid
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

umask 022
ulimit -t unlimited
ulimit -f unlimited
ulimit -d unlimited
#ulimit -s unlimited
ulimit -v unlimited
if [ -t 0 ]; then
 stty intr ^C
fi



ORACLE_BASE=/oracle/app/grid
ORACLE_HOME=/oracle/app/grid/product/19c/grid
ORACLE_SID=+ASM
LD_LIBRARY_PATH=\$ORACLE_HOME/lib
PATH=$PATH:/usr/local/bin:/usr/sbin:/usr/bin:/usr/openwin/bin:/usr/ucb:$ORACLE_HOME/bin
TEMP=/tmp
TMPDIR=/tmp
export ORACLE_BASE ORACLE_HOME ORACLE_SID LD_LIBRARY_PATH PATH TEMP TMPDIR
export EDITOR=vi

