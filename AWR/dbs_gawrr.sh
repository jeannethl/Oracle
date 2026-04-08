#!/bin/bash

## ------------------------------------------------------------------------
##
## VICTOR KHALTURIN 
##
## dbs_gawrr.sh - 02:02 29-Aug-2021 (003)
##
## The  script for creating multiple Oracle AWR reports automatically
## for specified snapshots range.
## 
## Before you can use the script, you must configure some operating system 
## environment variables for your database instance as the following
##
## export ORACLE_SID=
## export ORACLE_HOME=
## export PATH=${ORACLE_HOME}/bin:${PATH}
##
## ------------------------------------------------------------------------


## *************************************************
## * To automatically configure your Oracle environment variables
## *************************************************
## source /home/oracle/your_environment_file.env


## *************************************************
## * Terminate execution of the script when CTRL+C is pressed
## *************************************************
trap 'exit' SIGINT


## ********************************************************************
## * Debugging function
## ********************************************************************

silent () {

  if [ ! -z "${DEBUG}" ];
  then
    "$@"
  else
    "$@" &>/dev/null
  fi
}

## ********************************************************************
## * Exit 100
## ********************************************************************
TERMINATE() {
echo -e "\n  ${1}\n  Terminated.\n"
exit 100
}


## *************************************************
## * To verify that all required Oracle environment variables are in place
## *************************************************

DISPLAY_ORACLE_ENVIRONMENT_VARIABLES () {
echo "
  ==========================================
  ORACLE_SID  : ${ORACLE_SID}
  ORACLE_HOME : ${ORACLE_HOME}
  PATH        : ${PATH}
  ==========================================
"
}


## Checking whether Oracle environment variables are null
if [[ -z "${ORACLE_SID}" || -z "${ORACLE_HOME}" || -z "${PATH}" ]];
then 
  TERMINATE "One or more mandatory Oracle environment variables are NULL.\n  Can't connect to a database.\n$(DISPLAY_ORACLE_ENVIRONMENT_VARIABLES)\n"
fi

## Checking whether the sqlplus utility is accessible through the PATH variable.
silent which sqlplus

if [[ ${?} -ne 0 ]];
then 
  TERMINATE "Can't find the sqlplus utility in the PATH."
fi


## *************************************************
## * The script allows as an argument's value the numbers only. 
## *************************************************
ONLY_NUMBERS_ARE_ALLOWED () {

if [[ ! "${1}" =~ ^[0-9]+$ ]];
then
  TERMINATE "An incorrect parameter is passed for the argument [${agrument}].\n  Only numbers are allowed."
else 
  return "${1}"
fi 
}


## *************************************************
## * Testing a specified directory for the existence
## *************************************************
VERIFY_A_DIRECTORY_EXISTENCE () {

if [[ -z "${1}" || ! -d "${1}" || ! -w "${1}" ]];
then
  TERMINATE "The specified directory does not exist or it's not writable.\n  Directory : ${1}"
fi 

}

## *************************************************
## * Testing passed arguments to the script
## *************************************************

SCRIPT_ARGUMENTS=("$@")

for agrument in "${SCRIPT_ARGUMENTS[@]}";
do 
	case $(echo ${agrument} | tr '[:lower:]' '[:upper:]' ) in 
	     S=* )                FIRST_SNAPSHOT=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && ONLY_NUMBERS_ARE_ALLOWED "${FIRST_SNAPSHOT}" ;;
		 START=* )            FIRST_SNAPSHOT=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && ONLY_NUMBERS_ARE_ALLOWED "${FIRST_SNAPSHOT}" ;;
	     E=* )                LAST_SNAPSHOT=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && ONLY_NUMBERS_ARE_ALLOWED "${LAST_SNAPSHOT}" ;;
		 END=* )              LAST_SNAPSHOT=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && ONLY_NUMBERS_ARE_ALLOWED "${LAST_SNAPSHOT}" ;;
	     I=* )                INCREMENTAL_VALUE=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && ONLY_NUMBERS_ARE_ALLOWED "${INCREMENTAL_VALUE}" ;;
		 INCREMENT=* )        INCREMENTAL_VALUE=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && ONLY_NUMBERS_ARE_ALLOWED "${INCREMENTAL_VALUE}" ;;
		 D=* )                DIRECTORY_FOR_REPORTS=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && VERIFY_A_DIRECTORY_EXISTENCE "${DIRECTORY_FOR_REPORTS}" ;;
		 DIRECTORY=* )        DIRECTORY_FOR_REPORTS=$(echo ${agrument} | sed 's/[a-zA-Z]*=//g') && VERIFY_A_DIRECTORY_EXISTENCE "${DIRECTORY_FOR_REPORTS}" ;;
         DEBUG )              DEBUG=TRUE ;;
		 * )                  TERMINATE "Unsupported parameter [${agrument}]." ;;
	esac 
done



## *************************************************
## * Getting minimum and maximum snapshot ids from an AWR repository.
## *************************************************

MIN_AND_MAX_SNAPSHOT_IDS=$(sqlplus -s '/ as sysdba' <<EOF
SET HEAD OFF
SET PAGES 0
SET FEED OFF 
SELECT COUNT(SNAP_ID) TOTAL_SNAP_IDS,
       MIN(SNAP_ID) MIN_SNAP_ID,
	   TO_CHAR(MIN(END_INTERVAL_TIME),'DD-MON-YYYY HH24:MI','NLS_DATE_LANGUAGE = ENGLISH') MIN_SNAP_DATE,
       MAX(SNAP_ID) MAX_SNAP_ID,
	   TO_CHAR(MAX(END_INTERVAL_TIME),'DD-MON-YYYY HH24:MI','NLS_DATE_LANGUAGE = ENGLISH') MAX_SNAP_DATE
FROM 
       DBA_HIST_SNAPSHOT;
EOF
)

## Hint  : The query returns a row like the following : "23 1 28-AUG-2021 16:35 23 28-AUG-2021 21:10"
## Where :
##         1st position is the Total number of distinct snapshots in an AWR repository.
##         2nd position is a minimum snapshot ID.
##         3rd,4th positions represent a date when a minimum snapshot ID was captured.
##         5th column is a maximum snapshot ID 
##         6th,7th positions represent a date when a maximum snapshot ID was captured.


## Converting a String to an Array. 
MIN_AND_MAX_SNAPSHOT_IDS=(${MIN_AND_MAX_SNAPSHOT_IDS})

## Parsing the array and assigning array values to variables.
## Note : The position of an element in an array starts from 0.
TOTAL_SNAPSHOTS="${MIN_AND_MAX_SNAPSHOT_IDS[0]}"
MIN_SNAPSHOT_ID="${MIN_AND_MAX_SNAPSHOT_IDS[1]}"
MIN_SNAPSHOT_DATE="${MIN_AND_MAX_SNAPSHOT_IDS[2]} ${MIN_AND_MAX_SNAPSHOT_IDS[3]}"
MAX_SNAPSHOT_ID="${MIN_AND_MAX_SNAPSHOT_IDS[4]}"
MAX_SNAPSHOT_DATE="${MIN_AND_MAX_SNAPSHOT_IDS[5]} ${MIN_AND_MAX_SNAPSHOT_IDS[6]}"

## Checking whether there are at least two snapshots in an AWR repository.
if [[ ${TOTAL_SNAPSHOTS} -lt 2 ]];
then 
  TERMINATE "There is ${TOTAL_SNAPSHOTS} snapshot in an AWR repository. At least two snapshots are required."
fi



## *************************************************
## * Displaying all available AWR snapshots.
## *************************************************
LIST_OF_ALL_AVAILABLE_SNAPSHOTS () {
sqlplus -s '/ as sysdba' <<EOF 
SET PAGES 0
SET LINES 50
SET HEADING OFF
SET FEEDBACK OFF
COL SNAP_ID FOR 99999999999
COL STARTED_SNAP FOR A30 
SELECT SNAP_ID,TO_CHAR(END_INTERVAL_TIME,'DD-MON-YYYY HH24:MI') STARTED_SNAP FROM DBA_HIST_SNAPSHOT ORDER BY SNAP_ID;
EOF
}


## *************************************************
## * Displaying a help message if no arguments were specified.
## *************************************************

if [[ -z "${SCRIPT_ARGUMENTS[@]}" ]] || [[ "${#SCRIPT_ARGUMENTS[@]}" -eq 1 && ${DEBUG} == "TRUE" ]] ;
then
line="-------------------------------"

echo "
${line}
-- Available AWR Snapshots:
${line}
"

	LIST_OF_ALL_AVAILABLE_SNAPSHOTS
	
echo "
${line}
-- How to use the script
${line}

  ${0} s= e= [i= d= debug]

  [   s=  ] is a snapshot id to start from.
  [   e=  ] is a snapshot id to end on.
  [   i=  ] is an interval for getting the next snapshot id. The default value is 1.
  [   d=  ] is a directory for reports. The default one is a directory where the script is located.
  [ debug ] is the optional argument for printing out debug information while the script is executing.

"
	exit 0
fi


## *************************************************
## * Set default values 
## *************************************************

if [[ -z "${FIRST_SNAPSHOT}" ]];
then 
	FIRST_SNAPSHOT="${MIN_SNAPSHOT_ID}"
fi 

if [[ -z "${LAST_SNAPSHOT}" ]];
then 
	LAST_SNAPSHOT="${MAX_SNAPSHOT_ID}"
fi

if [[ -z "${INCREMENTAL_VALUE}" ]];
then 
	INCREMENTAL_VALUE=1 
fi 

if [[ -z "${DIRECTORY_FOR_REPORTS}" ]];
then 
	DIRECTORY_FOR_REPORTS="$(dirname $(readlink -f ${0}))"
fi



## *************************************************
## * Printing out snapshots details
## *************************************************
echo
echo "  Number of available snapshots  : ${TOTAL_SNAPSHOTS}"
echo "  Lower available snapshot ID    : ${MIN_SNAPSHOT_ID}"
echo "  Highest available snapshot ID  : ${MAX_SNAPSHOT_ID}"
echo 
echo "  Requested start snapshot ID    : ${FIRST_SNAPSHOT}"
echo "  Requested end snapshot ID      : ${LAST_SNAPSHOT}"
echo "  Requested snapshot interval    : ${INCREMENTAL_VALUE}"
echo "  Directory for reports          : ${DIRECTORY_FOR_REPORTS}"
echo     

## A specified snapshot ID is beyond the available snapshot range.
if [[ ${FIRST_SNAPSHOT} -lt ${MIN_SNAPSHOT_ID} ]];
then 
  TERMINATE "Requested start snapshot ["${FIRST_SNAPSHOT}"] does not exists."
fi 

if [[ ${LAST_SNAPSHOT} -gt ${MAX_SNAPSHOT_ID} ]];
then 
  TERMINATE "Requested end snapshot ["${LAST_SNAPSHOT}"] does not exists."
fi 

## The first snapshot cannot be greater than the last snapshot 
if [[ ${FIRST_SNAPSHOT} -gt ${LAST_SNAPSHOT} ]];
then 
  TERMINATE "The start snapshot ID [${FIRST_SNAPSHOT}] cannot be greater than the end snapshot ID [${LAST_SNAPSHOT}]."
fi 

## The start snapshot ID and the end snapshot id must not be the same.
if [[ ${FIRST_SNAPSHOT} -eq ${LAST_SNAPSHOT} ]];
then 
  TERMINATE "The start snapshot ID [${FIRST_SNAPSHOT}] and the end snapshot ID [${LAST_SNAPSHOT}] share the same ID."
fi 

## Modify a directory path. For instance /tmp to /tmp/
if [[ "${DIRECTORY_FOR_REPORTS: -1}" != "/" ]];
then
  DIRECTORY_FOR_REPORTS="${DIRECTORY_FOR_REPORTS}/"
fi


## *************************************************
## * Generating AWR reports 
## *************************************************

for (( snapshot_id=${FIRST_SNAPSHOT}; snapshot_id<=${LAST_SNAPSHOT}-${INCREMENTAL_VALUE}; snapshot_id+=${INCREMENTAL_VALUE} ));
do
	v_start_snapshot_id=${snapshot_id}
	v_end_snapshot_id=$((${snapshot_id} + ${INCREMENTAL_VALUE}))

silent sqlplus -s '/ as sysdba' <<EOF

COLUMN report_name NEW_VALUE report_name NOPRINT

SELECT '${DIRECTORY_FOR_REPORTS}' || UPPER(I.INSTANCE_NAME) || '_' ||
       TO_CHAR(DHS_S.END_INTERVAL_TIME,'DD_MON_YYYY_HH24MI','NLS_DATE_LANGUAGE = ENGLISH') || '_' ||
       TO_CHAR(DHS_E.END_INTERVAL_TIME,'HH24MI','NLS_DATE_LANGUAGE = ENGLISH') || '_' ||
	   DHS_S.SNAP_ID || '_' || DHS_E.SNAP_ID || '.html' report_name
FROM
       V\$INSTANCE I,
	   DBA_HIST_SNAPSHOT DHS_S,
	   DBA_HIST_SNAPSHOT DHS_E
WHERE
       I.INSTANCE_NUMBER = DHS_S.INSTANCE_NUMBER AND
	   I.INSTANCE_NUMBER = DHS_E.INSTANCE_NUMBER AND 
       DHS_S.SNAP_ID = ${v_start_snapshot_id} AND 
	   DHS_E.SNAP_ID = ${v_end_snapshot_id};
	   


define report_type  = 'html'
define num_days     = ''
define begin_snap   = ${v_start_snapshot_id}
define end_snap     = ${v_end_snapshot_id}

@?/rdbms/admin/awrrpt.sql
EOF

printf "\\40\\40%-35s\n" "${v_start_snapshot_id} - ${v_end_snapshot_id}"
done
echo 

#####################################################
## End of dbs_gawrr.sh script 
## dbs_gawrr.sh - 02:02 29-Aug-2021 (003)
#####################################################