Verificar que el servidor tenga salida a internet

2.- Instalamos los siguientes paquetes

apt install gcc 
apt install make 
apt install htop 
apt install gzip 
apt install gunzip 
apt install zip 
apt install unzip 
apt install compress 
apt install uncompress
apt install rsync
apt install libreadline-dev
apt install zlib1g
apt install zlib1g-dev
apt install pgsql
apt install libdbd-pgsql
apt install postgresql-14
                
3.- Creamos el usuario y grupo postgres

                groupadd postgres
                useradd -g postgres postgres

userdel -r postgres
                passwd postgres
                Bqsmt7aral8*.
                Caracas17*.

4.- Validamos los directorios o FS

Nota: en el mismo disco C, estan los binarios y data del postgres.

                mkdir -p /data_postgres        --50GB  Tamaño de cada FS
                mkdir -p /logs_postgres        --30GB  Tamaño de cada FS
                mkdir -p /backup              --50GB  Tamaño de cada FS
                mkdir -p /data_postgre/binarios


5.- Damos permiso 

                chown -R postgres:postgres /backup 
                chown -R postgres:postgres /data_GADSRP
                chown -R postgres:postgres /data_GADCRTP
                chown -R postgres:postgres /logs_GADSRP 
                chown -R postgres:postgres /logs_GADCRTP
                chown -R postgres:postgres /postgres



6.- Ir a la ruta /etc/security y agregar al archivo limits.conf lo siguientes
                
postgres soft nofile 1024   
postgres hard nofile 65536  
postgres soft nproc 4094  
postgres hard nproc 16384  
postgres soft stack 10240  
postgres hard stack 32768  

                
Descargar paquetes del siguiente link depende version a instalar:

https://www.postgresql.org/ftp/source/

Luego q lo descargues.

Pasarlo al servidor a instalar

        scp postgresql-14.5.tar.gz postgres@10.134.0.166:/Binarios_Postgres/postgresql-14.5.tar.gz



en la carpeta binarios 

7.- Descomprimimos el archivo tar.gz

                gzip -d postgresql-14.5.tar.gz
                tar -xvf postgresql-14.5.tar
                tar -xvf extensiones.tar
                tar -xvf extensiones_so.tar



8.- Asignar permiso al directorio creado

                chown postgres:postgres postgresql-14.5

9.- Entrar al directorio anterior y ejecutar

                ./configure -prefix=/postgres/binarios/postgresql-14.5

                NOTA: Este comando debe terminar sin errores, una vez ejecutado sin error se prosigue con la instalacion

10.- Ahora compilamos las funtes e instalamos

                make
                make install


Esperar por el FS de wall!************

14.5 Una vez instlado nos dirigimos a /Binarios_Postgres/postgresql-14.5/bin y ejecutamos lo siguiente para iniciar la bd

                ./initdb -D /data_GADSRP/GADSRP -X /data_GADSRP/wall
                
                ./pg_ctl -D /data_GADSRP/GADSRP -l /logs_GADSRP/postgres_gadsrp.log start

12.- para bajar los servicios de postgres

                ./pg_ctl -D /data_GADSRP/GADSRP -l /logs_GADSRP/postgres_gadsrp.log -m fast stop

13.- Para dar status de postgres

                ./pg_ctl -D /data_GADSRP/GADSRP status

14.- Para reiniciar postgres

                ./pg_ctl -D /data_GADSRP/GADSRP -l /logs_GADSRP/postgres_gadsrp.log -m fast restart

****************************************************************************************************************************

Por cada instancia

14.5 Una vez instlado nos dirigimos a /Binarios_Postgres/postgresql-14.5/bin y ejecutamos lo siguiente para iniciar la bd

                ./initdb -D /data_GADCRTP/GADCRTP -X /data_GADCRTP/wall
                
                ./pg_ctl -D /data_GADCRTP/GADCRTP -l /logs_GADCRTP/postgres_gadcrtp.log start

12.- para bajar los servicios de postgres

                ./pg_ctl -D /data_GADCRTP/GADCRTP -l /logs_GADCRTP/postgres_gadcrtp.log -m fast stop

13.- Para dar status de postgres

                ./pg_ctl -D /data_GADCRTP/GADCRTP status

14.- Para reiniciar postgres

                ./pg_ctl -D /data_GADCRTP/GADCRTP -l /logs_GADCRTP/postgres_gadcrtp.log -m fast restart


Configuracion de la Bases de datos con los recursos disponible del servidor

32GB de RAM
16 CPU
300 Conexiones --- Esto puede ser modificado.


***Con Storage SSD

# DB Version: 14
# OS Type: linux
# DB Type: web
# Total Memory (RAM): 32 GB
# CPUs num: 16
# Connections num: 300
# Data Storage: ssd


listen_adrresess = '*'                  
max_connections = 300
shared_buffers = 8GB                    
effective_cache_size = 24GB
maintenance_work_mem = 2GB              
checkpoint_completion_target = 0.9      
wal_buffers = 16MB
default_statistics_target = 100
effective_io_concurrency = 200         
work_mem = 6990kB                      
min_wal_size = 1GB
max_wal_size = 4GB
max_worker_processes = 16
max_parallel_workers_per_gather = 4
max_parallel_workers = 16
max_parallel_maintenance_workers = 4
log_destination = 'stderr'              
logging_collector = on                  
log_min_duration_statement = 0          
log_connections = on                  
log_duration = on                     
log_hostname = on                      
log_directory = '/logs_postgres/CMBMP' 
log_filename = 'postgres_cmbmp.log'



**Cambiarlo directamente desde la BD

ALTER SYSTEM SET max_connections = '150';
ALTER SYSTEM SET shared_buffers = '1GB';
ALTER SYSTEM SET effective_cache_size = '3GB';
ALTER SYSTEM SET maintenance_work_mem = '256MB';
ALTER SYSTEM SET checkpoint_completion_target = '0.9';
ALTER SYSTEM SET wal_buffers = '16MB';
ALTER SYSTEM SET default_statistics_target = '100';
ALTER SYSTEM SET random_page_cost = '1.1';
ALTER SYSTEM SET effective_io_concurrency = '200';
ALTER SYSTEM SET work_mem = '6990kB';
ALTER SYSTEM SET min_wal_size = '2GB';
ALTER SYSTEM SET max_wal_size = '4GB';
ALTER SYSTEM SET max_worker_processes = '2';
ALTER SYSTEM SET max_parallel_workers_per_gather = '1';
ALTER SYSTEM SET max_parallel_workers = '2';


Dentro de PSQL  

Colocarle la clave a postgres

alter user postgres with password 'postgres';


**************************************************************************


root@clebdpg01:/home/administrador cat .profile
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi



PATH=$PATH:$HOME/bin

export PGHOME=/postgres/binarios/postgresql-15.5
export PGBIN=/postgres/binarios/postgresql-15.5/bin
export PGVERSION=15.5
export PATH=$PGBIN:$PATH
export MANPATH=$PGHOME/man:$MANPATH
export LD_LIBRARY_PATH=$PGHOME/lib:$LD_LIBRARY_PATH


export PATH

echo -e "\n\e[1;33m- ACCESOS A BASES DE DATOS -\n"
echo -e "* menubd\n\e[0m"




[postgres@plposqlbd01: ~]$ vi .bash_profile_menu
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

configcmbmq() {
export PGDATA=/postgres/data
export PGLOG=/postgres/log
export PGHOME=/postgres/binarios/15.5
export PGBIN=$PGHOME/bin
export PGVERSION=15.5
export PATH=$PGBIN:$PATH
export MANPATH=$PGHOME/man:$MANPATH
export LD_LIBRARY_PATH=$PGHOME/lib:$LD_LIBRARY_PATH
export PGPORT=5455
export DATE=`date "+%Y-%m-%d"`;
export LOG=postgres_zabbix.log
echo -e "\n### COMANDOS PARA INICIAR BD ZABBIX ###"
echo -e "* zabbixBD_start\n* zabbixBD_stop\n* zabbixBD_restart\n* zabbixBD_status\n"
echo -e "+ SINGLE"
echo -e "+ PUERTO: $PGPORT "
echo -e "+ DATA: $PGDATA \n"
echo -e "+ VERSION POSTGRESQL: $PGVERSION \n"
echo -e "+ INGRESAR A POSTGRESQL: psql \n"
}

clear
echo -e "\e[1;33m---------------------"
echo -e "    MENU DE ACCESO   "
echo -e "---------------------\e[0m"
echo -e "\e[1;33m1. zabbixBD \e[0m"
echo -e "\e[1;33m2. EXIT \e[0m"
echo -e "Ingrese su opcion:"
read -t 2 OPCION

case $OPCION in
1) configcmbmq ;;
esac







[postgres@plposqlbd01: ~]$ vi .bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR=vim

#####Alias Inicio MENUBD

alias menubd='. /home/postgres/./.bash_profile_menu'


#####Alias Inicio BD zabbixBD
alias zabbixBD_status='/postgres/binarios/15.5/bin/./pg_ctl -D /postgres/data status'
alias zabbixBD_start='/postgres/binarios/15.5/bin/./pg_ctl -D /postgres/data -l /postgres/log/postgres_zabbixBD.log start'
alias zabbixBD_stop='/postgres/binarios/15.5/bin/./pg_ctl -D /postgres/data -l /postgres/log/postgres_zabbixBD.log -m fast stop'
alias zabbixBD_restart='/postgres/binarios/15.5/bin/./pg_ctl -D /postgres/data -l /postgres/log/postgres_zabbixBD.log -m fast restart'



[postgres@plposqlbd01: ~]$




**************************************************************************************

Configuracion del PG_HBA

Usuarios que se van a conectar  

##Conexiones Personalizadas Grupo de Bases de Datos

host     all            all             180.183.69.0/24            md5
host     all            all             180.183.68.0/24            md5


************************************************************************************

CREATE DATABASE GADSRP;
CREATE DATABASE GADCRTP;


*************************************************************************


### Opcional dependiendo los proveedores
Scripts para subir servicio de postgres cuando inicie el servidor


root@clebdpg01:/etc/init.d# vi inicio_postgres.sh
#!/bin/bash

su postgres -c "/postgres/binarios/postgresql-14.5/bin/./pg_ctl -D /data_postgres/CMBMP -l /logs_postgres/CMBMP/postgres_cmbmp.log start"


chmod 755 inicio_postgres.sh



*************************************************************************



Creacion del backup

postgres@plposqlbd01:/backup/scripts$ cat backup_full_gadsrp.sh
#!/usr/bin/bash

export PGDATA=/data_GADSRP/GADSRP
export PGLOG=/logs_GADSRP
export PGHOME=/postgres/binarios/postgresql-14.5/
export BIN=/postgres/binarios/postgresql-14.5/bin/

export DATE=`date "+%Y%m%d_%H%M"`
export LOG=/logs_GADSRP/backup_full/backup_full_gadsrp_$DATE.log
export RUTA_DUMP=/backup/GADSRP/backup_full/


echo $DATE Inicio Del Backup
$BIN/./pg_dump -U postgres -p 5489 -d gadsrp > $RUTA_DUMP/backfull_gadsrp_$DATE.dump
$BIN/./pg_dump -U postgres -p 5489 -d gadsrp > $RUTA_DUMP/backfull_gadsrp_$DATE.sql

echo $DATE Fin del Backup

##Borrado de Backup Con mas de Dias#####################

find $RUTA_DUMP -name "*.dump" -mtime +90 -exec rm -rf {} \;
find $RUTA_DUMP -name "*.sql" -mtime +90 -exec rm -rf {} \;

postgres@plposqlbd01:/backup/scripts$ cat backup_full_gadcrtp.sh
#!/usr/bin/bash

export PGDATA=/data_GADCRTP/
export PGLOG=/logs_GADCRTP/
export PGHOME=/postgres/binarios/postgresql-14.5/
export BIN=/postgres/binarios/postgresql-14.5/bin/

export DATE=`date "+%Y%m%d_%H%M"`
export LOG=/logs_GADCRTP//backup_full/backup_full_gadcrtp_$DATE.log
export RUTA_DUMP=/backup/GADCRTP/backup_full


echo $DATE Inicio Del Backup
$BIN/./pg_dump -U postgres -p 5490 -d gadcrtp > $RUTA_DUMP/backfull_gadcrtp_$DATE.dump
$BIN/./pg_dump -U postgres -p 5490 -d gadcrtp > $RUTA_DUMP/backfull_gadcrtp_$DATE.sql

echo $DATE Fin del Backup

##Borrado de Backup Con mas de Dias#####################

find $RUTA_DUMP -name "*.dump" -mtime +90 -exec rm -rf {} \;
find $RUTA_DUMP -name "*.sql" -mtime +90 -exec rm -rf {} \;



************************************************************************

Configurar crontab 

ls -ld /etc/cron.allow

chmod 755 /etc/cron.allow

echo postgres > /etc/cron.allow

cat /etc/cron.allow