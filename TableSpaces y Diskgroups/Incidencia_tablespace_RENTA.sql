--Resolución de la alarma de RENTA
/*1.Se hizo un df -h para ver que espacio del fylesistem se podria usar:
oracle9i@bdvsun02.banvenez.com:/db_1$ df -h
Filesystem             size   used  avail capacity  Mounted on
rpool/ROOT/s10s_u11wos_24a
                        98G    30G    44G    42%    /
/devices                 0K     0K     0K     0%    /devices
ctfs                     0K     0K     0K     0%    /system/contract
proc                     0K     0K     0K     0%    /proc
mnttab                   0K     0K     0K     0%    /etc/mnttab
swap                    60G   448K    60G     1%    /etc/svc/volatile
objfs                    0K     0K     0K     0%    /system/object
sharefs                  0K     0K     0K     0%    /etc/dfs/sharetab
/platform/sun4v/lib/libc_psr/libc_psr_hwcap3.so.1
                        74G    30G    44G    42%    /platform/sun4v/lib/libc_psr.so.1
/platform/sun4v/lib/sparcv9/libc_psr/libc_psr_hwcap3.so.1
                        74G    30G    44G    42%    /platform/sun4v/lib/sparcv9/libc_psr.so.1
fd                       0K     0K     0K     0%    /dev/fd
swap                    60G   144M    60G     1%    /tmp
swap                    60G    88K    60G     1%    /var/run
APLICACION             851G    20K   469G     1%    /APLICACION
APLICACION2_EMC         31G    31K    11G     1%    /APLICACION2_EMC
ARCHIVE                392G    35K   362G     1%    /ARCHIVE
ARCHIVE/RENTA          392G    30G   362G     8%    /ARCHIVE/RENTA
ARCHIVE/ROCA           392G    31K   362G     1%    /ARCHIVE/ROCA
ARCHIVE_NEW            294G    31K   234G     1%    /ARCHIVE_NEW
BDRE                   546G    24K   135G     1%    /BDRE
BDRE/data              546G   333G   135G    72%    /BDRE/data
BDRE/index             546G    56G   135G    30%    /BDRE/index
BDRE/system            546G    22G   135G    14%    /BDRE/system
CTLEXP                 343G    24K   132G     1%    /CTLEXP
CTLEXP/data            343G    63G   132G    33%    /CTLEXP/data
CTLEXP/index           343G   123G   132G    49%    /CTLEXP/index
CTLEXP/system          343G    24G   132G    16%    /CTLEXP/system
CTLEXPINDX              88G    32K    88G     1%    /CTLEXPINDX
CTLEXPINDX/indx         88G    31K    88G     1%    /CTLEXPINDX/indx
CTLEXPTEMP              20G    32K    20G     1%    /CTLEXPTEMP
CTLEXPTEMP/temp         20G    31K    20G     1%    /CTLEXPTEMP/temp
CTLEXPUNDO              20G    32K    20G     1%    /CTLEXPUNDO
CTLEXPUNDO/undo         20G    31K    20G     1%    /CTLEXPUNDO/undo
DBDATA2232_EMC          90G    14G    23G    38%    /DBDATA2232_EMC
DBDATA2233_EMC          63G    31K    13G     1%    /DBDATA2233_EMC
DBDATA2243_EMC          49G    31K    19G     1%    /DBDATA2243_EMC
EXPORT2_NEW            294G    31K   165G     1%    /EXPORT2_NEW
EXPORTDB               637G    31K   384G     1%    /EXPORTDB
FISAACP                 29G    24K    12G     1%    /FISAACP
FISAACP/data            29G    11G    12G    50%    /FISAACP/data
FISAACP/index           29G   5.1G    12G    31%    /FISAACP/index
FISAACP/system          29G   1.5G    12G    12%    /FISAACP/system
ORACLE_BIN              98G    31K    48G     1%    /ORACLE_BIN
PTMOSQ                 277G    24K   120G     1%    /PTMOSQ
PTMOSQ/data            277G   107G   120G    48%    /PTMOSQ/data
PTMOSQ/index           277G    16G   120G    12%    /PTMOSQ/index
PTMOSQ/system          277G    35G   120G    23%    /PTMOSQ/system
PTMOSQ_DATA             98G    32K    23G     1%    /PTMOSQ_DATA
PTMOSQ_DATA/data        98G    75G    23G    77%    /PTMOSQ_DATA/data
PTMOSQ_INDX             57G    32K    27G     1%    /PTMOSQ_INDX
PTMOSQ_INDX/index       57G    30G    27G    53%    /PTMOSQ_INDX/index
PTMOSQ_REDO1           4.9G    32K   2.7G     1%    /PTMOSQ_REDO1
PTMOSQ_REDO1/redo1     4.9G   2.2G   2.7G    45%    /PTMOSQ_REDO1/redo1
PTMOSQ_REDO2           4.9G    32K   2.7G     1%    /PTMOSQ_REDO2
PTMOSQ_REDO2/redo2     4.9G   2.2G   2.7G    45%    /PTMOSQ_REDO2/redo2
PTMOSQ_REDO3           4.9G    32K   4.9G     1%    /PTMOSQ_REDO3
PTMOSQ_REDO3/redo3     4.9G    31K   4.9G     1%    /PTMOSQ_REDO3/redo3
PTMOSQ_TEMP             23G    32K    14G     1%    /PTMOSQ_TEMP
PTMOSQ_TEMP/temp        23G   8.2G    14G    37%    /PTMOSQ_TEMP/temp
RENTA                  4.8T    24K   940G     1%    /RENTA
RENTA/data             4.8T   2.8T   940G    76%    /RENTA/data
RENTA/index            4.8T   1.0T   940G    53%    /RENTA/index
RENTA/system           4.8T    52G   940G     6%    /RENTA/system
RENTACONTROL01         980M    21K   968M     1%    /RENTACONTROL01
RENTACONTROL01/control01
                       980M    12M   968M     2%    /RENTACONTROL01/control01
RENTACONTROL02         980M    21K   968M     1%    /RENTACONTROL02
RENTACONTROL02/control02
                       980M    12M   968M     2%    /RENTACONTROL02/control02
RENTADATA              4.3T    23K   582G     1%    /RENTADATA
RENTADATA/data         4.3T   3.8T   582G    87%    /RENTADATA/data
RENTADATA01            1.5T    23K   320G     1%    /RENTADATA01
RENTADATA01/data       1.5T   1.1T   320G    79%    /RENTADATA01/data
RENTADATA01/index      1.5T   9.5G   320G     3%    /RENTADATA01/index
RENTADATA02            1.3T    21K    34G     1%    /RENTADATA02
RENTADATA02/data       1.3T   1.3T    34G    98%    /RENTADATA02/data
RENTADATA03            1.7T    32K   389G     1%    /RENTADATA03
RENTADATA03/data       1.7T   1.3T   389G    78%    /RENTADATA03/data
RENTADRP               1.2T    35K   1.2T     1%    /RENTADRP
RENTADRP/data          1.2T    81G   1.2T     7%    /RENTADRP/data
RENTADRP/index         1.2T    31K   1.2T     1%    /RENTADRP/index
RENTADRP/system        1.2T   159K   1.2T     1%    /RENTADRP/system
RENTAINDEX             1.9T    21K   529G     1%    /RENTAINDEX
RENTAINDEX/index       1.9T   1.3T   529G    73%    /RENTAINDEX/index
RENTAINDEX01           1.4T   1.1T   357G    76%    /RENTAINDEX01
RENTAINDEX02           1.6T    32K   529G     1%    /RENTAINDEX02
RENTAINDEX02/index     1.6T   1.1T   529G    69%    /RENTAINDEX02/index
RENTAREDOA              20G    32K    20G     1%    /RENTAREDOA
RENTAREDOA/rentaredoa
                        20G    31K    20G     1%    /RENTAREDOA/rentaredoa
RENTAREDOB              20G    32K    20G     1%    /RENTAREDOB
RENTAREDOB/rentaredob
                        20G    31K    20G     1%    /RENTAREDOB/rentaredob
RENTAREDOC              20G    32K    20G     1%    /RENTAREDOC
RENTAREDOC/rentaredoc
                        20G    31K    20G     1%    /RENTAREDOC/rentaredoc
RENTAREDOLOGA           29G    21K    20G     1%    /RENTAREDOLOGA
RENTAREDOLOGA/loga      29G   9.0G    20G    31%    /RENTAREDOLOGA/loga
RENTAREDOLOGB           29G    21K    20G     1%    /RENTAREDOLOGB
RENTAREDOLOGB/logb      29G   9.0G    20G    31%    /RENTAREDOLOGB/logb
RENTASYSTEM             12G    21K   9.7G     1%    /RENTASYSTEM
RENTASYSTEM/system      12G   2.1G   9.7G    18%    /RENTASYSTEM/system
RENTATMP               352G    21K   151G     1%    /RENTATMP
RENTATMP/tmp           352G   201G   151G    58%    /RENTATMP/tmp
RENTAUNDO              348G    21K   348G     1%    /RENTAUNDO
RENTAUNDO/undo         348G    20K   348G     1%    /RENTAUNDO/undo
RENTAUNDO01            588G    32K   267G     1%    /RENTAUNDO01
RENTAUNDO01/undo       588G   320G   267G    55%    /RENTAUNDO01/undo
RENTA_SDO              254G    31K   246G     1%    /RENTA_SDO
APLICACION2_EMC/aplicacion2
                        31G    20G    11G    65%    /aplicacion2
RENTA_SDO/sdo          254G   8.6G   246G     4%    /aplicacion2/renta/sdo
ARCHIVE_NEW/archive    294G    60G   234G    21%    /archive
DBDATA2232_EMC/dbdata2232
                        90G    53G    23G    70%    /dbdata2232
DBDATA2233_EMC/dbdata2233
                        63G    50G    13G    80%    /dbdata2233
DBDATA2243_EMC/dbdata2243
                        49G    30G    19G    63%    /dbdata2243
rpool/export            98G    32K    44G     1%    /export
rpool/export/home       98G   4.9G    44G    11%    /export/home
EXPORT2_NEW/export2    294G   129G   165G    44%    /export2
EXPORTDB/exportdb      637G   252G   384G    40%    /exportdb
APLICACION/ftp2        851G   382G   469G    45%    /ftp2
ORACLE_BIN/oracle       98G    50G    48G    51%    /oracle
rpool                   98G   106K    44G     1%    /rpool
oracle9i@bdvsun02.banvenez.com:/db_1$ ls -ltr /RENTADATA02
total 5
*/





/*
2.Posterior se lanzo el comando ls -ltr para listar lo que contenia /RENTADATA02 
oracle9i@bdvsun02.banvenez.com:/db_1$ ls -ltr /RENTADATA02
total 5
drwxr-xr-x   2 oracle9i oinstall      61 Sep 30 09:02 data/
oracle9i@bdvsun02.banvenez.com:/db_1$ ^[
oracle9i@bdvsun02.banvenez.com:/db_1$
oracle9i@bdvsun02.banvenez.com:/db_1$
oracle9i@bdvsun02.banvenez.com:/db_1$
oracle9i@bdvsun02.banvenez.com:/db_1$ ls -ltr /RENTADATA02/data
total 2734662771
-rw-r-----   1 oracle9i oinstall 21474852864 Nov  1 08:16 data_segmentacion01a_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 16106143744 Nov  1 08:16 data_segmentacion01d_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 16106143744 Nov  1 08:17 data_segmentacion01b_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 1056768 Nov  1 08:17 data01_QPA.dbf
-rw-r-----   1 oracle9i oinstall 16106143744 Nov  1 08:17 data_segmentacion01c_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 13958660096 Nov  1 08:18 data_segmentacion01e_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 8589950976 Nov  1 08:18 data_rdia15_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:18 data01n_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:18 data01o_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 10737434624 Nov  1 08:18 data_dia06d_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 1073758208 Nov  1 08:18 data_negocio_mes03b_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 1073758208 Nov  1 08:18 data_negocio_mes04b_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 1073758208 Nov  1 08:18 data_negocio_mes07b_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 1073758208 Nov  1 08:18 data_negocio_mes08b_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:18 data01p_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 12884918272 Nov  1 08:18 data_segmentacion01g_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 12884918272 Nov  1 08:18 data_mes04a_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:18 data_cliente01r_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:18 data01r_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 8589950976 Nov  1 08:18 DATA_MES10d_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 8589950976 Nov  1 08:18 data_dia02g_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 10737434624 Nov  1 08:18 data_fidelizacion01l_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:18 data_cliente01s_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 4294983680 Nov  1 08:18 data_fidelizacion01m_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 1073758208 Nov  1 08:18 data_mes07e_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 12884918272 Nov  1 08:19 data_mes04b_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 12884918272 Nov  1 08:19 data_mes04c_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 10737434624 Nov  1 08:19 data_dia06e_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 9663692800 Nov  1 08:19 data_dia01i_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:19 data01u_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:20 data01v_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 8589950976 Nov  1 08:20 data_dia03g_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 8589950976 Nov  1 08:20 data_dia03h_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 24696078336 Nov  1 08:20 data_sn_hist01a_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01t_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:20 data01w_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01aa_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01uu_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01bb_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01gg_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01cc_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01ff_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 26843553792 Nov  1 08:20 data_cliente01ee_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212262912 Nov  1 08:20 data_cliente01rr_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 37580980224 Nov  1 08:20 data01x_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:20 data01kk_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:20 data01vv_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:20 data01z_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:20 data01y_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:20 data001.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:20 data002.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:20 data003.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:21 data006.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:21 data007.dbf
-rw-r-----   1 oracle9i oinstall 32212271104 Nov  1 08:21 data009.dbf
-rw-r-----   1 oracle9i oinstall 42949689344 Nov  1 08:22 data004.dbf
-rw-r-----   1 oracle9i oinstall 12884918272 Nov  1 08:33 data_mes04d_RENTA.dbf
-rw-r-----   1 oracle9i oinstall 37580980224 Nov  1 08:35 data005.dbf
-rw-r-----   1 oracle9i oinstall 9663692800 Nov  1 08:41 data_dia01k_RENTA.dbf
*/

/*
3. Despues se lanzaron los comandos:
export ORACLE_SID=RENTA
sqlplus "/ as sysdba"
Este ultimo comando esta entre comillas ya que es un servidor muy viejo
*/




--4. Ya en la base de datos se procedio a usar los siguientes QUERYs
--Ver espacio en tablespaces

SET PAGES 999
COL TABLESPACE_NAME FORMAT A40
COL "SIZE MB" FORMAT 999,999,999
COL "FREE MB" FORMAT 99,999,999
COL "% USED" FORMAT 999
SELECT     TSU.TABLESPACE_NAME, CEIL(TSU.USED_MB) "SIZE MB"
,    DECODE(CEIL(TSF.FREE_MB), NULL,0,CEIL(TSF.FREE_MB)) "FREE MB"
,    DECODE(100 - CEIL(TSF.FREE_MB/TSU.USED_MB*100), NULL, 100,
               100 - CEIL(TSF.FREE_MB/TSU.USED_MB*100)) "% USED"
FROM    (SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 USED_MB
    FROM     DBA_DATA_FILES GROUP BY TABLESPACE_NAME UNION ALL
    SELECT     TABLESPACE_NAME || '  **TEMP**'
    ,    SUM(BYTES)/1024/1024 USED_MB
    FROM     DBA_TEMP_FILES GROUP BY TABLESPACE_NAME) TSU
,    (SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 FREE_MB
    FROM     DBA_FREE_SPACE GROUP BY TABLESPACE_NAME) TSF
WHERE    TSU.TABLESPACE_NAME = TSF.TABLESPACE_NAME (+)
--and TSU.TABLESPACE_NAME = 'DATA_IDENTITY_LOG'
ORDER    BY 4
/


/*
TABLESPACE_NAME                               SIZE MB     FREE MB % USED
---------------------------------------- ------------ ----------- ------
DATA_BPUB                                       2,048       2,047      0
DATA_DIA02                                     57,344      57,334      0
DATA_NEGOCIO_DIA01                              2,048       2,048      0
DATA_NEGOCIO_DIA04                              1,536       1,536      0
DATA_NEGOCIO_DIA05                              2,048       2,048      0
DATA_NEGOCIO_DIA03                              2,048       2,048      0
DATA_NEGOCIO_DIA02                              1,536       1,536      0
DATA_NEGOCIO_DIA06                              1,536       1,536      0
DATA_NEGOCIO_MES01                              2,048       2,048      0
DATA_NEGOCIO_MES10                              2,048       2,048      0
DATA_NEGOCIO_MES09                              2,048       2,048      0
DATA_NEGOCIO_MES08                              2,048       2,048      0
DATA_NEGOCIO_MES07                              2,048       2,048      0
DATA_NEGOCIO_MES06                              2,048       2,048      0
DATA_NEGOCIO_MES05                              2,048       2,048      0
DATA_NEGOCIO_MES04                              2,048       2,048      0
DATA_NEGOCIO_MES03                              2,048       2,048      0
DATA_NEGOCIO_MES02                              2,048       2,048      0
TBL_EXPERTECH                                      50          50      0
PERFSTAT                                           12          12      0
INDX_NEGOCIO_DIA04                                512         512      0
INDX_NEGOCIO_DIA02                                512         512      0
INDX_MES07                                     19,456      19,456      0
INDX_BPUB                                       1,024       1,024      0
DATA_NEGOCIO_MES13                              2,048       2,048      0
DATA_NEGOCIO_MES12                              2,048       2,048      0
DATA_NEGOCIO_MES11                              2,560       2,560      0
DATA_NEGOCIO_DIA07                              2,048       2,048      0
INDX_NEGOCIO_MES13                                512         512      0
INDX_NEGOCIO_MES12                                512         512      0
INDX_NEGOCIO_MES11                                512         512      0
INDX_NEGOCIO_MES02                                512         512      0
INDX_NEGOCIO_DIA06                                512         512      0
INDX_MES06                                     22,016      21,792      1
INDX_NEGOCIO_DIA01                              1,024       1,009      1
INDX_SN_HIST                                    2,000       1,978      1
INDX_NEGOCIO_DIA03                                512         497      2
INDX_NEGOCIO_DIA05                                512         497      2
INDX_NEGOCIO_DIA07                                512         497      2
DATA_MES07                                     32,768      31,680      3
INDX_NEGOCIO_MES10                                512         495      3
INDX_NEGOCIO_MES09                                512         495      3
INDX_NEGOCIO_MES08                                512         495      3
INDX_NEGOCIO_MES07                                512         495      3
INDX_NEGOCIO_MES06                                512         495      3
INDX_NEGOCIO_MES03                              2,048       1,980      3
INDX_NEGOCIO_MES04                              1,024         990      3
INDX_NEGOCIO_MES01                                512         495      3
INDX_NEGOCIO_MES05                                512         495      3
DATA_QPA                                            1           1      6
INDX_QPA                                            1           1      6
INDX_RSS6M                                          1           1      6
INDX_AGENDA                                         1           1      6
DATA_RSS6M                                          1           1      6
DATA_MES06                                     45,056      41,013      8
INDX_RFM                                        4,309       3,940      8
DATA_CARTAS_CRED                                5,120       4,507     11
DATA_RFM                                       19,456      16,854     13
INDX_DIA02                                     39,936      34,204     14
INDX_SEGMENTACION_SEM                          29,000      21,964     24
DATA_GASTO                                      3,000       2,126     29
UNDOTBS                                       327,680     214,224     34
DATA_BMOVIL                                     5,120       3,147     38
INDX_BMOVIL                                     3,072       1,842     40
SYSTEM                                          2,048       1,216     40
DATA_TRANSACCION                            2,125,824   1,237,791     41
DATA_SN                                        48,160      27,247     43
INDX_TRANSACCION3                           1,081,344     609,523     43
INDX_TRANSACCION5                             589,824     324,382     45
DATA_BAL                                        3,072       1,632     46
INDX_DIA04                                     56,320      29,503     47
INDX_DIA03                                     55,296      28,607     48
INDX_TRANSACCION2                           1,026,048     532,290     48
INDX_TRANSACCION4                             670,720     335,525     49
DATA_EDN                                          640         318     50
DATA_AGENDA                                       200          96     52
INDX_DIA05                                     51,200      24,383     52
INDX_DIA06                                     49,152      22,719     53
INDX_BAL                                        1,536         697     54
INDX_SUMARIA                                   19,000       8,368     55
QUEST                                             400         180     55
INDX_TRANSACCION                                  384         169     56
DATA_MES08                                     57,344      24,314     57
DATA_MES12                                     57,344      23,897     58
EUL                                             1,536         616     59
INDX_MES03                                     32,768      13,248     59
INDX_GASTO                                      1,024         410     59
DATA_MES13                                     55,296      21,852     60
DATA_FIDELIZACION                             182,272      69,796     61
INDX_DIA07                                     43,008      16,383     61
DATA_MES01                                    114,688      44,439     61
DATA_MES09                                     53,248      20,029     62
DATA_MES10                                     53,248      19,031     64
DATA_SUMARIA                                   47,432      16,834     64
INDX_CALLCENTER                                14,336       4,920     65
TOOLS                                          30,720      10,535     65
DATA_CALLCENTER                                32,772      10,821     66
DATA_MES02                                     51,200      16,675     67
INDX_CARTAS_CRED                                  300          98     67
INDX_FIDELIZACION                              36,864      11,840     67
DATA_DIA03                                     71,680      22,325     68
DATA_SEGMENTACION_SEM                          76,000      23,914     68
DATA_RDIA                                     147,256      46,135     68
DATA_MES03                                     49,152      14,930     69
INDX_RMCA                                      73,728      22,472     69
INDX_EDN                                          120          35     71
INDX_MAU                                        2,048         576     71
DATA_MES11                                     48,128      13,444     72
INDX_MES12                                     26,624       7,440     72
INDX_CHEQUES                                   16,384       4,440     72
DATA_DIA01                                    123,904      32,237     73
INDX_MES11                                     26,624       6,984     73
DATA_USU                                       45,576      12,117     73
DATA_RMCA                                     326,656      86,576     73
DATA_CHEQUES                                  108,544      27,925     74
DATA_DIA05                                     51,200      12,449     75
DATA_DIA06                                     51,200      12,758     75
DATA_DIA07                                     50,176      11,627     76
INDX_DIA01                                     75,776      17,878     76
INDX_MES09                                     25,600       6,080     76
DATA_MAU                                       44,032       9,728     77
DATA_MES04                                     89,088      19,689     77
DATA_RMC                                       48,128      10,744     77
INDX_SN                                       118,784      26,561     77
INDX_RMC                                       29,696       6,624     77
INDX_MES13                                     24,576       5,456     77
INDX_CONTACTO                                  14,336       3,265     77
DATA_DIA04                                     49,152      10,488     78
INDX_CLIENTE                                  102,400      22,266     78
INDX_MES08                                     24,576       5,184     78
DATA_CONTACTO                                  38,912       7,880     79
INDX_MES01                                     49,152      10,120     79
INDX_MES10                                     24,576       4,944     79
INDX_MES02                                     24,576       4,936     79
INDX_MES04                                     49,152       8,431     82
DATA_MES05                                     40,960       6,701     83
DATA_SEGMENTACION                             168,960      25,386     84
INDX_SEGMENTACION                              55,296       8,773     84
INDX_MES05                                     24,576       3,880     84
DATA_SN_HIST                                  314,368      43,081     86
DATA_CLIENTE                                1,433,600     184,080     87
INDX                                          157,696      18,327     88
DATA                                        4,275,200     116,398     97
TEMP_RENTA  **TEMP**                          184,320           0    100
TEMP_USU_RENTA  **TEMP**                       75,776           0    100
TEMPORAL  **TEMP**                              3,072           0    100
*/
--Como podemos ver el Tablespace de DATA que es el que se alarmo esta en 97%

--Luego vimos los datafiles a ver cual se podia usar y seguir un patro al momento de agregarle el nombre

set linesize 4000
set pages 999
col FILE_NAME format a70
col FILE_ID format 999,990
col TABLESPACE_NAME format a35
col RELATIVE_FNO format 9999
select FILE_NAME,FILE_ID,TABLESPACE_NAME, bytes/1024/1024 MB, RELATIVE_FNO,AUTOEXTENSIBLE, status 
from dba_data_files
where TABLESPACE_NAME in ('DATA')
/

--resize
/RENTADATA02/data/data010.dbf
ALTER DATABASE DATAFILE '/RENTADATA02/data/data007.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA02/data/data005.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA02/data/data006.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA02/data/data001.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA02/data/data002.dbf' RESIZE 61440M; 

ALTER DATABASE DATAFILE '/RENTADATA02/data/data003.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA02/data/data004.dbf' RESIZE 61440M;


ALTER DATABASE DATAFILE '/RENTADATA02/data/data01x_RENTA.dbf' RESIZE 61440M;   
ALTER DATABASE DATAFILE '/RENTADATA02/data/data01y_RENTA.dbf' RESIZE 61440M;   
ALTER DATABASE DATAFILE '/RENTADATA02/data/data01z_RENTA.dbf' RESIZE 61440M;   

SELECT tablespace_name, SUM(bytes) AS used_space
FROM v$temp_space_header
GROUP BY TEMP_RENTA;


ALTER DATABASE DATAFILE '/RENTADATA03/data/data01a_RENTA.dbf' RESIZE 61440M;

ALTER DATABASE DATAFILE '/RENTADATA01/data/data01l_RENTA.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data01m_RENTA.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data01u_RENTA.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data01dd_RENTA.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data01oo_RENTA.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data01qq_RENTA.dbf' RESIZE 61440M;


ALTER DATABASE DATAFILE '/RENTADATA01/data/data009.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data010.dbf' RESIZE 61440M;
ALTER DATABASE DATAFILE '/RENTADATA01/data/data011.dbf' RESIZE 61440M;

/*

FILE_NAME                                                               FILE_ID TABLESPACE_NAME                             MB RELATIVE_FNO AUT STATUS
---------------------------------------------------------------------- -------- ----------------------------------- ---------- ------------ --- ---------
/RENTADATA/data/data01a1_RENTA.dbf                                          818 DATA                                     51200          818 NO  AVAILABLE
/RENTADATA/data/data01b1_RENTA.dbf                                          819 DATA                                     51200          819 NO  AVAILABLE
/RENTADATA/data/data01c1_RENTA.dbf                                          820 DATA                                     30720          820 NO  AVAILABLE
/RENTADATA/data/data01d1_RENTA.dbf                                          821 DATA                                     30720          821 NO  AVAILABLE
/RENTA/data/data01h_RENTA.dbf                                               262 DATA                                     40960          262 NO  AVAILABLE
/RENTA/data/data01g_RENTA.dbf                                               258 DATA                                     40960          258 NO  AVAILABLE
/RENTA/data/data01f_RENTA.dbf                                               256 DATA                                     40960          256 NO  AVAILABLE
/RENTA/data/data01e_RENTA.dbf                                               249 DATA                                     40960          249 NO  AVAILABLE
/RENTA/data/data01d_RENTA.dbf                                               247 DATA                                     40960          247 NO  AVAILABLE
/RENTA/data/data01c_RENTA.dbf                                               244 DATA                                     40960          244 NO  AVAILABLE
/RENTA/data/data01b_RENTA.dbf                                               234 DATA                                     40960          234 NO  AVAILABLE
/RENTADATA/data/data01a_RENTA.dbf                                             3 DATA                                     51200            3 NO  AVAILABLE
/RENTADATA/data/data01b_RENTA.dbf                                           324 DATA                                     40960          324 NO  AVAILABLE
/RENTADATA/data/data01j_RENTA.dbf                                           347 DATA                                     40960          347 NO  AVAILABLE
/RENTADATA/data/data01i_RENTA.dbf                                           372 DATA                                     40960          372 NO  AVAILABLE
/RENTADATA/data/data01k_RENTA.dbf                                           393 DATA                                     40960          393 NO  AVAILABLE
/RENTADATA01/data/data01l_RENTA.dbf                                         396 DATA                                     40960          396 NO  AVAILABLE
/RENTADATA01/data/data01m_RENTA.dbf                                         397 DATA                                     40960          397 NO  AVAILABLE
/RENTADATA02/data/data01o_RENTA.dbf                                         410 DATA                                     40960          410 NO  AVAILABLE
/RENTADATA02/data/data01n_RENTA.dbf                                         411 DATA                                     40960          411 NO  AVAILABLE
/RENTADATA02/data/data01p_RENTA.dbf                                         432 DATA                                     40960          432 NO  AVAILABLE
/RENTADATA01/data/data01q_RENTA.dbf                                         438 DATA                                     40960          438 NO  AVAILABLE
/RENTADATA02/data/data01r_RENTA.dbf                                         472 DATA                                     40960          472 NO  AVAILABLE
/RENTA/data/data01s_RENTA.dbf                                               529 DATA                                     40960          529 NO  AVAILABLE
/RENTADATA01/data/data01t_RENTA.dbf                                         559 DATA                                     40960          559 NO  AVAILABLE
/RENTADATA02/data/data01u_RENTA.dbf                                         617 DATA                                     40960          617 NO  AVAILABLE
/RENTADATA02/data/data01v_RENTA.dbf                                         673 DATA                                     40960          673 NO  AVAILABLE
/RENTADATA02/data/data01w_RENTA.dbf                                         708 DATA                                     40960          708 NO  AVAILABLE
/RENTADATA01/data/data01u_RENTA.dbf                                         712 DATA                                     40960          712 NO  AVAILABLE
/RENTADATA/data/data01z_RENTA.dbf                                           715 DATA                                     40960          715 NO  AVAILABLE
/RENTADATA/data/data01x_RENTA.dbf                                           716 DATA                                     30720          716 NO  AVAILABLE
/RENTADATA/data/data01c_RENTA.dbf                                           721 DATA                                     40960          721 NO  AVAILABLE
/RENTADATA/data/data01d_RENTA.dbf                                           722 DATA                                     31744          722 NO  AVAILABLE
/RENTADATA/data/data01aa_RENTA.dbf                                          727 DATA                                     32768          727 NO  AVAILABLE
/RENTADATA/data/data01bb_RENTA.dbf                                          728 DATA                                     40960          728 NO  AVAILABLE
/RENTADATA/data/data01cc_RENTA.dbf                                          729 DATA                                     31744          729 NO  AVAILABLE
/RENTADATA/data/data01e_RENTA.dbf                                           731 DATA                                     30720          731 NO  AVAILABLE
/RENTADATA/data/data01ee_RENTA.dbf                                          732 DATA                                     30720          732 NO  AVAILABLE
/RENTADATA/data/data01f_RENTA.dbf                                           733 DATA                                     30720          733 NO  AVAILABLE
/RENTADATA/data/data01g_RENTA.dbf                                           734 DATA                                     30720          734 NO  AVAILABLE
/RENTADATA/data/data01h_RENTA.dbf                                           735 DATA                                     30720          735 NO  AVAILABLE
/RENTADATA/data/data01ii_RENTA.dbf                                          736 DATA                                     30720          736 NO  AVAILABLE
/RENTADATA/data/data01ff_RENTA.dbf                                          753 DATA                                     30720          753 NO  AVAILABLE
/RENTADATA/data/data01gg_RENTA.dbf                                          754 DATA                                     30720          754 NO  AVAILABLE
/RENTADATA/data/data01hh_RENTA.dbf                                          755 DATA                                     30720          755 NO  AVAILABLE
/RENTADATA/data/data01m_RENTA.dbf                                           756 DATA                                     30720          756 NO  AVAILABLE
/RENTADATA/data/data01l_RENTA.dbf                                           757 DATA                                     30720          757 NO  AVAILABLE
/RENTADATA/data/data01mm_RENTA.dbf                                          758 DATA                                     30720          758 NO  AVAILABLE
/RENTADATA/data/data01nn_RENTA.dbf                                          759 DATA                                     30720          759 NO  AVAILABLE
/RENTADATA/data/data01n_RENTA.dbf                                           760 DATA                                     30720          760 NO  AVAILABLE
/RENTADATA/data/data01p_RENTA.dbf                                           761 DATA                                     30720          761 NO  AVAILABLE
/RENTADATA/data/data01pp_RENTA.dbf                                          762 DATA                                     30720          762 NO  AVAILABLE
/RENTADATA/data/data01s_RENTA.dbf                                           763 DATA                                     30720          763 NO  AVAILABLE
/RENTADATA/data/data01ss_RENTA.dbf                                          764 DATA                                     30720          764 NO  AVAILABLE
/RENTADATA/data/data01t_RENTA.dbf                                           765 DATA                                     30720          765 NO  AVAILABLE
/RENTADATA/data/data01tt_RENTA.dbf                                          766 DATA                                     30720          766 NO  AVAILABLE
/RENTADATA/data/data01u_RENTA.dbf                                           767 DATA                                     30720          767 NO  AVAILABLE
/RENTADATA/data/data01uu_RENTA.dbf                                          768 DATA                                     30720          768 NO  AVAILABLE
/RENTADATA/data/data01xx_RENTA.dbf                                          769 DATA                                     30720          769 NO  AVAILABLE
/RENTADATA/data/data01ll_RENTA.dbf                                          770 DATA                                     30720          770 NO  AVAILABLE
/RENTADATA/data/data01jj_RENTA.dbf                                          771 DATA                                     30720          771 NO  AVAILABLE
/RENTADATA/data/data01y_RENTA.dbf                                           772 DATA                                     30720          772 NO  AVAILABLE
/RENTADATA/data/data01yy_RENTA.dbf                                          773 DATA                                     30720          773 NO  AVAILABLE
/RENTADATA/data/data01ww_RENTA.dbf                                          774 DATA                                     30720          774 NO  AVAILABLE
/RENTADATA/data/data01zz_RENTA.dbf                                          775 DATA                                     30720          775 NO  AVAILABLE
/RENTADATA/data/data01zzz_RENTA.dbf                                         776 DATA                                     30720          776 NO  AVAILABLE
/RENTADATA/data/data01www_RENTA.dbf                                         777 DATA                                     30720          777 NO  AVAILABLE
/RENTADATA/data/data01ttt_RENTA.dbf                                         778 DATA                                     30720          778 NO  AVAILABLE
/RENTADATA/data/data01jjj_RENTA.dbf                                         780 DATA                                     30720          780 NO  AVAILABLE
/RENTADATA/data/data01uuu_RENTA.dbf                                         781 DATA                                     30720          781 NO  AVAILABLE
/RENTADATA/data/data01ppp_RENTA.dbf                                         782 DATA                                     30720          782 NO  AVAILABLE
/RENTADATA/data/data01nnn_RENTA.dbf                                         783 DATA                                     30720          783 NO  AVAILABLE
/RENTADATA/data/data01fff_RENTA.dbf                                         784 DATA                                     30720          784 NO  AVAILABLE
/RENTADATA/data/data01eee_RENTA.dbf                                         785 DATA                                     30720          785 NO  AVAILABLE
/RENTADATA/data/data01yyy_RENTA.dbf                                         786 DATA                                     30720          786 NO  AVAILABLE
/RENTADATA/data/data01mmm_RENTA.dbf                                         789 DATA                                     30720          789 NO  AVAILABLE
/RENTADATA/data/data01sss_RENTA.dbf                                         791 DATA                                     30720          791 NO  AVAILABLE
/RENTADATA/data/data01tttt_RENTA.dbf                                        792 DATA                                     30720          792 NO  AVAILABLE
/RENTADATA/data/data01nnnn_RENTA.dbf                                        793 DATA                                     30720          793 NO  AVAILABLE
/RENTADATA/data/data01hhh_RENTA.dbf                                         794 DATA                                     30720          794 NO  AVAILABLE
/RENTADATA/data/data01ssss_RENTA.dbf                                        795 DATA                                     30720          795 NO  AVAILABLE
/RENTADATA/data/data01uuuu_RENTA.dbf                                        796 DATA                                     40960          796 NO  AVAILABLE
/RENTADATA/data/data01xxx_RENTA.dbf                                         797 DATA                                     40960          797 NO  AVAILABLE
/RENTADATA/data/data01yyyy_RENTA.dbf                                        799 DATA                                     40960          799 NO  AVAILABLE
/RENTADATA/data/data01zzzz_RENTA.dbf                                        800 DATA                                     40960          800 NO  AVAILABLE
/RENTADATA/data/data01jjjj_RENTA.dbf                                        801 DATA                                     40960          801 NO  AVAILABLE
/RENTADATA/data/data01kkkk_RENTA.dbf                                        802 DATA                                     40960          802 NO  AVAILABLE
/RENTADATA/data/data01llll_RENTA.dbf                                        803 DATA                                     51200          803 NO  AVAILABLE
/RENTADATA/data/data01mmmm_RENTA.dbf                                        804 DATA                                     51200          804 NO  AVAILABLE
/RENTADATA/data/data01xxxx_RENTA.dbf                                        805 DATA                                     30720          805 NO  AVAILABLE
/RENTADATA02/data/data01x_RENTA.dbf                                         809 DATA                                     35840          809 NO  AVAILABLE
/RENTADATA02/data/data01y_RENTA.dbf                                         810 DATA                                     30720          810 NO  AVAILABLE
/RENTADATA02/data/data01z_RENTA.dbf                                         811 DATA                                     30720          811 NO  AVAILABLE
/RENTADATA01/data/data01dd_RENTA.dbf                                        812 DATA                                     31744          812 NO  AVAILABLE
/RENTADATA01/data/data01oo_RENTA.dbf                                        813 DATA                                     30720          813 NO  AVAILABLE
/RENTADATA01/data/data01qq_RENTA.dbf                                        814 DATA                                     30720          814 NO  AVAILABLE
/RENTADATA01/data/data01rr_RENTA.dbf                                        815 DATA                                     30720          815 NO  AVAILABLE
/RENTADATA02/data/data01kk_RENTA.dbf                                        816 DATA                                     40960          816 NO  AVAILABLE
/RENTADATA02/data/data01vv_RENTA.dbf                                        817 DATA                                     30720          817 NO  AVAILABLE
/RENTADATA/data/data01f1_RENTA.dbf                                          822 DATA                                     40960          822 NO  AVAILABLE
/RENTADATA/data/data01g1_RENTA.dbf                                          823 DATA                                     51200          823 NO  AVAILABLE
/RENTADATA/data/data01h1_RENTA.dbf                                          824 DATA                                     40960          824 NO  AVAILABLE
/RENTADATA/data/data01i1_RENTA.dbf                                          825 DATA                                     40960          825 NO  AVAILABLE
/RENTADATA/data/data01j1_RENTA.dbf                                          826 DATA                                     40960          826 NO  AVAILABLE
/RENTADATA/data/data01k1_RENTA.dbf                                          827 DATA                                     40960          827 NO  AVAILABLE
/RENTADATA02/data/data001.dbf                                               828 DATA                                     30720          828 NO  AVAILABLE
/RENTADATA02/data/data002.dbf                                               829 DATA                                     40960          829 NO  AVAILABLE
/RENTADATA/data/data003.dbf                                                 830 DATA                                     40960          830 NO  AVAILABLE
/RENTADATA/data/data004.dbf                                                 831 DATA                                     30720          831 NO  AVAILABLE
/RENTADATA02/data/data003.dbf                                               832 DATA                                     40960          832 NO  AVAILABLE
/RENTADATA02/data/data004.dbf                                               833 DATA                                     40960          833 NO  AVAILABLE
/RENTADATA02/data/data006.dbf                                               834 DATA                                     30720          834 NO  AVAILABLE
/RENTADATA02/data/data005.dbf                                               835 DATA                                     35840          835 NO  AVAILABLE
/RENTADATA02/data/data007.dbf                                               836 DATA                                     30720          836 NO  AVAILABLE
/RENTA/data/data_transaccion39_RENTA.dbf                                    837 DATA                                     30720          837 NO  AVAILABLE
/RENTA/data/data_transaccion40_RENTA.dbf                                    838 DATA                                     20480          838 NO  AVAILABLE
/RENTA/data/data_transaccion41_RENTA.dbf                                    839 DATA                                     20480          839 NO  AVAILABLE
/RENTA/data/data_transaccion42_RENTA.dbf                                    840 DATA                                     30720          840 NO  AVAILABLE
/RENTA/data/data_transaccion43_RENTA.dbf                                    841 DATA                                     30720          841 NO  AVAILABLE
/oracle/app/oracle/product/9.2.0.8/db_1/dbs/data_transaccion44_RENTA.d      842 DATA                                                    842     AVAILABLE
bf

/RENTA/data/data_transaccion44_RENTA.dbf                                    843 DATA                                     30720          843 NO  AVAILABLE
/RENTADATA02/data/data009.dbf                                               846 DATA                                     30720          846 NO  AVAILABLE

122 rows selected.
*/

--Despues agregamos un Tablespace
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA02/data/data010.dbf' SIZE 32767M AUTOEXTEND OFF;

--Despues se intento agregar otro tablespace pero ocurrio un error puesto que el fylesistem /RENTADATA02/data/ se habia quedado sin espacio este es el error:
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA02/data/data011.dbf' SIZE 32767M AUTOEXTEND OFF;
/*
ERROR at line 1:
ORA-19502: write error on file "/RENTADATA02/data/data011.dbf", blockno 125697 (blocksize=16384)
ORA-27063: skgfospo: number of bytes read/written is incorrect
Additional information: 114688
Additional information: 1048576
ORA-19502: write error on file "/RENTADATA02/data/data011.dbf", blockno 125633 (blocksize=16384)
ORA-27063: skgfospo: number of bytes read/written is incorrect
Additional information: 507904
Additional information: 1048576
*/

--Se cambio el fylesistem a /RENTADATA01/data/ y se le agregaron 3 tablespaces quedando en 94%

ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data001.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data002.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data003.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data004.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data005.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data006.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data007.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data008.dbf' SIZE 32767M AUTOEXTEND OFF;
ALTER TABLESPACE DATA ADD DATAFILE '/RENTADATA01/data/data009.dbf' SIZE 32767M AUTOEXTEND OFF;
/*
TABLESPACE_NAME                               SIZE MB     FREE MB % USED
---------------------------------------- ------------ ----------- ------
DATA_BPUB                                       2,048       2,047      0
DATA_DIA02                                     57,344      57,334      0
DATA_NEGOCIO_DIA01                              2,048       2,048      0
DATA_NEGOCIO_DIA04                              1,536       1,536      0
DATA_NEGOCIO_DIA05                              2,048       2,048      0
DATA_NEGOCIO_DIA03                              2,048       2,048      0
DATA_NEGOCIO_DIA02                              1,536       1,536      0
DATA_NEGOCIO_DIA06                              1,536       1,536      0
DATA_NEGOCIO_MES01                              2,048       2,048      0
DATA_NEGOCIO_MES10                              2,048       2,048      0
DATA_NEGOCIO_MES09                              2,048       2,048      0
DATA_NEGOCIO_MES08                              2,048       2,048      0
DATA_NEGOCIO_MES07                              2,048       2,048      0
DATA_NEGOCIO_MES06                              2,048       2,048      0
DATA_NEGOCIO_MES05                              2,048       2,048      0
DATA_NEGOCIO_MES04                              2,048       2,048      0
DATA_NEGOCIO_MES03                              2,048       2,048      0
DATA_NEGOCIO_MES02                              2,048       2,048      0
TBL_EXPERTECH                                      50          50      0
PERFSTAT                                           12          12      0
INDX_NEGOCIO_DIA04                                512         512      0
INDX_NEGOCIO_DIA02                                512         512      0
INDX_MES07                                     19,456      19,456      0
INDX_BPUB                                       1,024       1,024      0
DATA_NEGOCIO_MES13                              2,048       2,048      0
DATA_NEGOCIO_MES12                              2,048       2,048      0
DATA_NEGOCIO_MES11                              2,560       2,560      0
DATA_NEGOCIO_DIA07                              2,048       2,048      0
INDX_NEGOCIO_MES13                                512         512      0
INDX_NEGOCIO_MES12                                512         512      0
INDX_NEGOCIO_MES11                                512         512      0
INDX_NEGOCIO_MES02                                512         512      0
INDX_NEGOCIO_DIA06                                512         512      0
INDX_MES06                                     22,016      21,792      1
INDX_NEGOCIO_DIA01                              1,024       1,009      1
INDX_SN_HIST                                    2,000       1,978      1
INDX_NEGOCIO_DIA03                                512         497      2
INDX_NEGOCIO_DIA05                                512         497      2
INDX_NEGOCIO_DIA07                                512         497      2
DATA_MES07                                     32,768      31,680      3
INDX_NEGOCIO_MES10                                512         495      3
INDX_NEGOCIO_MES09                                512         495      3
INDX_NEGOCIO_MES08                                512         495      3
INDX_NEGOCIO_MES07                                512         495      3
INDX_NEGOCIO_MES06                                512         495      3
INDX_NEGOCIO_MES03                              2,048       1,980      3
INDX_NEGOCIO_MES04                              1,024         990      3
INDX_NEGOCIO_MES01                                512         495      3
INDX_NEGOCIO_MES05                                512         495      3
DATA_QPA                                            1           1      6
INDX_QPA                                            1           1      6
INDX_RSS6M                                          1           1      6
INDX_AGENDA                                         1           1      6
DATA_RSS6M                                          1           1      6
DATA_MES06                                     45,056      41,013      8
INDX_RFM                                        4,309       3,940      8
DATA_CARTAS_CRED                                5,120       4,507     11
DATA_RFM                                       19,456      16,854     13
INDX_DIA02                                     39,936      34,204     14
INDX_SEGMENTACION_SEM                          29,000      21,964     24
DATA_GASTO                                      3,000       2,126     29
UNDOTBS                                       327,680     213,760     34
DATA_BMOVIL                                     5,120       3,147     38
INDX_BMOVIL                                     3,072       1,842     40
SYSTEM                                          2,048       1,216     40
DATA_TRANSACCION                            2,125,824   1,237,216     41
DATA_SN                                        48,160      27,247     43
INDX_TRANSACCION3                           1,081,344     604,869     44
INDX_TRANSACCION5                             589,824     324,382     45
DATA_BAL                                        3,072       1,632     46
INDX_DIA04                                     56,320      29,503     47
INDX_DIA03                                     55,296      28,607     48
INDX_TRANSACCION2                           1,026,048     532,290     48
INDX_TRANSACCION4                             670,720     335,525     49
DATA_EDN                                          640         318     50
DATA_AGENDA                                       200          96     52
INDX_DIA05                                     51,200      24,383     52
INDX_DIA06                                     49,152      22,719     53
INDX_BAL                                        1,536         697     54
INDX_SUMARIA                                   19,000       8,368     55
QUEST                                             400         180     55
INDX_TRANSACCION                                  384         169     56
DATA_MES08                                     57,344      24,314     57
DATA_MES12                                     57,344      23,897     58
EUL                                             1,536         616     59
INDX_MES03                                     32,768      13,248     59
INDX_GASTO                                      1,024         410     59
DATA_MES13                                     55,296      21,852     60
DATA_FIDELIZACION                             182,272      69,796     61
INDX_DIA07                                     43,008      16,383     61
DATA_MES01                                    114,688      44,439     61
DATA_MES09                                     53,248      20,029     62
DATA_MES10                                     53,248      19,031     64
DATA_SUMARIA                                   47,432      16,834     64
INDX_CALLCENTER                                14,336       4,920     65
TOOLS                                          30,720      10,535     65
DATA_CALLCENTER                                32,772      10,821     66
DATA_MES02                                     51,200      16,675     67
INDX_CARTAS_CRED                                  300          98     67
INDX_FIDELIZACION                              36,864      11,840     67
DATA_DIA03                                     71,680      22,325     68
DATA_SEGMENTACION_SEM                          76,000      23,914     68
DATA_RDIA                                     147,256      46,135     68
DATA_MES03                                     49,152      14,930     69
INDX_RMCA                                      73,728      22,472     69
INDX_EDN                                          120          35     71
INDX_MAU                                        2,048         576     71
DATA_MES11                                     48,128      13,444     72
INDX_MES12                                     26,624       7,440     72
INDX_CHEQUES                                   16,384       4,440     72
DATA_DIA01                                    123,904      32,237     73
INDX_MES11                                     26,624       6,984     73
DATA_USU                                       45,576      12,117     73
DATA_RMCA                                     326,656      86,576     73
DATA_CHEQUES                                  108,544      27,925     74
DATA_DIA05                                     51,200      12,449     75
DATA_DIA06                                     51,200      12,758     75
DATA_DIA07                                     50,176      11,627     76
INDX_DIA01                                     75,776      17,878     76
INDX_MES09                                     25,600       6,080     76
DATA_MAU                                       44,032       9,728     77
DATA_MES04                                     89,088      19,689     77
DATA_RMC                                       48,128      10,744     77
INDX_SN                                       118,784      26,561     77
INDX_RMC                                       29,696       6,624     77
INDX_MES13                                     24,576       5,456     77
INDX_CONTACTO                                  14,336       3,265     77
DATA_DIA04                                     49,152      10,488     78
INDX_CLIENTE                                  102,400      22,266     78
INDX_MES08                                     24,576       5,184     78
DATA_CONTACTO                                  38,912       7,880     79
INDX_MES01                                     49,152      10,120     79
INDX_MES10                                     24,576       4,944     79
INDX_MES02                                     24,576       4,936     79
INDX_MES04                                     49,152       8,431     82
DATA_MES05                                     40,960       6,701     83
DATA_SEGMENTACION                             168,960      25,386     84
INDX_SEGMENTACION                              55,296       8,773     84
INDX_MES05                                     24,576       3,880     84
DATA_SN_HIST                                  314,368      43,081     86
DATA_CLIENTE                                1,433,600     184,080     87
INDX                                          157,696      18,327     88
DATA                                        4,406,268     247,466     94
TEMP_RENTA  **TEMP**                          184,320           0    100
TEMP_USU_RENTA  **TEMP**                       75,776           0    100
TEMPORAL  **TEMP**                              3,072           0    100

146 rows selected.
*/