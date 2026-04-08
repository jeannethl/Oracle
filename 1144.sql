

select table_name,pct_free,pct_used from dba_tables where table_name='RDX_NETHUB';

select * from DBA_SEGMENTS where SEGMENT_NAME='PK_RDX_NETHUB';

select * from DBA_SEGMENTS where SEGMENT_NAME='RDX_NETHUB';

ALTER TABLE TX.RDX_NETHUB PCTFREE 95;

alter table tx.RDX_NETHUB move update indexes online;


ALTER index TX.PK_RDX_NETHUB rebuild PCTFREE 95 online;





select * from v$mystat;
select sid, serial# from v$session where sid=4735;


alter system kill session '4735,27214' immediate;


alter system set cursor_sharing=FORCE;

alter system set session_cached_cursors=8192 scope=spfile;






*****************


alter session set sort_area_size=100000000;

-----

CREATE INDEX TX.IDX_BALANCEHIST_ACCOUNT ON TX.BALANCEHIST
(ACCOUNTID, DAY) parallel 8 nologging;
alter index TX.IDX_BALANCEHIST_ACCOUNT noparallel logging;

CREATE UNIQUE INDEX TX.PK_BALANCEHIST ON TX.BALANCEHIST
(DAY, ACCOUNTID) parallel 8 nologging;
alter index TX.PK_BALANCEHIST noparallel logging;


ALTER TABLE TX.BALANCEHIST
 ADD CONSTRAINT PK_BALANCEHIST
  PRIMARY KEY
  (DAY, ACCOUNTID)
  RELY
  USING INDEX TX.PK_BALANCEHIST;



  DROP INDEX TX.IDX_BALANCEHIST_ACCOUNT;

CREATE INDEX TX.IDX_BALANCEHIST_ACCOUNT ON TX.BALANCEHIST
(ACCOUNTID, DAY)
  TABLESPACE RBS_ACCOUNT_IDX
  PCTFREE    10
  INITRANS   2
  MAXTRANS   255
  STORAGE    (
              BUFFER_POOL      DEFAULT
             )
LOCAL (  
  PARTITION BALANCEHIST_2022_03_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_03_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_04_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_05_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_06_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_07_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_08_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_09_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_10_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_11_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2022_12_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_01_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_02_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_03_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_04_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_05_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_06_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_07_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_08_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_09_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_10_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_11_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2023_12_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_01_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_02_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_03_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_04_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_05_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_06_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_07_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_08_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_09_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_05
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_06
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_07
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_08
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_09
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_10
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_11
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_12
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_13
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_14
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_15
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_16
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_17
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_18
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_19
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_20
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_21
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_22
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_23
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_24
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_25
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_26
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_27
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_28
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_29
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_30
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_10_31
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_11_01
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_11_02
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_11_03
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION BALANCEHIST_2024_11_04
    LOGGING
    NOCOMPRESS 
    TABLESPACE RBS_ACCOUNT_IDX
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                BUFFER_POOL      DEFAULT
               )
) parallel 8 nologging;

ALTER INDEX TX.IDX_BALANCEHIST_ACCOUNT noparallel logging
   MONITORING USAGE;
