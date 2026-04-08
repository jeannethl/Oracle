Aumentar_tablespace_automatico .sql

vi tbs_extend.sql


alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;
alter tablespace DATA_CCENLNP add datafile '+DG_DATA_CCENLNH' size 30G;



sqlplus / as sysdba

@tbs_extend.sql


asi comienzan a agregarse automaticamente los discos.