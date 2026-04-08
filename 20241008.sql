
*********


select * from v$mystat

select sid, serial# from v$session where sid=8463;
       SID    SERIAL#
---------- ----------
      8463      38305

alter system kill session '8463,38305' immediate;



***************
*******************

 select sum(bytes)/1024/1024/1024 x from v$datafile
 select sum(bytes)/1024/1024/1024 x from v$tempfile;


***************
*******************


log_archive_dest_1                   string LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=TRZSP ALTERNATE=LOG_ARCHIVE_DEST_10
log_archive_dest_10                  string  location=+FRA02_TRZSP valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=TRZSP ALTERNATE=LOG_ARCHIVE_DEST_1

alter system set log_archive_dest_10='location=+FRA02_TRZSP valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=TRZSP ALTERNATE=LOG_ARCHIVE_DEST_1';


