
SUN1330P
asmcmd lsdsk -k -G DG_CTRL1_PAGOFP
asmcmd lsdsk -k -G DG_CTRL2_PAGOFP
asmcmd lsdsk -k -G DG_DATA_PAGOFP
asmcmd lsdsk -k -G DG_REDO01_PAGOFP
asmcmd lsdsk -k -G DG_REDO02_PAGOFP
asmcmd lsdsk -k -G DG_REDO03_PAGOFP
asmcmd lsdsk -k -G FRA



asmcmd lsdsk -k -G DG_AUDIT
asmcmd lsdsk -k -G DG_DATA
asmcmd lsdsk -k -G DG_OCRVOTE
asmcmd lsdsk -k -G DG_REDO
asmcmd lsdsk -k -G FRA


NAME                              FREE_MB   TOTAL_MB   PCT_USED
------------------------------ ---------- ---------- ----------

DG_CTRL1_PAGOFP                      5780       6120       5.56
DG_CTRL2_PAGOFP                      5780       6120       5.56
DG_DATA_PAGOFP                    1350200   12332056      89.05
DG_REDO01_PAGOFP                    14128      20464      30.96
DG_REDO02_PAGOFP                    14128      20464      30.96
DG_REDO03_PAGOFP                    20364      20464        .49
FRA                               1476220    1534944       3.83


DG_CTRL1_PAGOFP
Total_MB  Free_MB  OS_MB  Name                Failgroup             Path
    2040     1928   2041  PWCTRL1_PAGOFP_001  PWCTRL1_PAGOFP_001    /dev/rdsk/c1d209s6
    2040     1924   2041  PWCTRL1_PAGOFP_002  PWCTRL1_PAGOFP_002    /dev/rdsk/c1d210s6
    2040     1928   2041  PWCTRL1_PAGOFP_003  PWCTRL1_PAGOFP_003    /dev/rdsk/c1d211s6

DG_CTRL2_PAGOFP
Total_MB  Free_MB  OS_MB  Name                Failgroup             Path
    2040     1928   2041  PWCTRL2_PAGOFP_001  PWCTRL2_PAGOFP_001    /dev/rdsk/c1d212s6
    2040     1924   2041  PWCTRL2_PAGOFP_002  PWCTRL2_PAGOFP_002    /dev/rdsk/c1d213s6
    2040     1928   2041  PWCTRL2_PAGOFP_003  PWCTRL2_PAGOFP_003    /dev/rdsk/c1d214s6

DG_DATA_PAGOFP
Total_MB  Free_MB   OS_MB  Name                 Failgroup           Path
  511648    56028  511648  PWDATA_PAGOFP_001    PWDATA_PAGOFP_001   /dev/rdsk/c1d189s6
  511648    56016  511648  PWDATA_PAGOFP_002    PWDATA_PAGOFP_002   /dev/rdsk/c1d190s6
  511648    56024  511648  PWDATA_PAGOFP_003    PWDATA_PAGOFP_003   /dev/rdsk/c1d191s6
  511648    56020  511648  PWDATA_PAGOFP_004    PWDATA_PAGOFP_004   /dev/rdsk/c1d192s6
  511648    56016  511648  PWDATA_PAGOFP_005    PWDATA_PAGOFP_005   /dev/rdsk/c1d193s6
  511648    56024  511648  PWDATA_PAGOFP_006    PWDATA_PAGOFP_006   /dev/rdsk/c1d194s6
  511648    56024  511648  PWDATA_PAGOFP_007    PWDATA_PAGOFP_007   /dev/rdsk/c1d195s6
  511648    56012  511648  PWDATA_PAGOFP_008    PWDATA_PAGOFP_008   /dev/rdsk/c1d196s6
  511648    56008  511648  PWDATA_PAGOFP_009    PWDATA_PAGOFP_009   /dev/rdsk/c1d197s6
  511648    56016  511648  PWDATA_PAGOFP_010    PWDATA_PAGOFP_010   /dev/rdsk/c1d198s6
  511648    56016  511648  PWDATA_PAGOFP_011    PWDATA_PAGOFP_011   /dev/rdsk/c1d199s6
  511648    56028  511648  PWDATA_PAGOFP_012    PWDATA_PAGOFP_012   /dev/rdsk/c1d200s6
  511648    56016  511648  PWDATA_PAGOFP_013    PWDATA_PAGOFP_013   /dev/rdsk/c1d217s6
  511648    56016  511648  PWDATA_PAGOFP_014    PWDATA_PAGOFP_014   /dev/rdsk/c1d218s6
  511648    56008  511648  PWDATA_PAGOFP_015    PWDATA_PAGOFP_015   /dev/rdsk/c1d219s6
  511648    56028  511648  PWDATA_PAGOFP_020    PWDATA_PAGOFP_020   /dev/rdsk/c1d220s6
  511648    56028  511648  PWDATA_PAGOFP_021    PWDATA_PAGOFP_021   /dev/rdsk/c1d221s6
  511976    56052  511976  PWDATA_PAGOFP_016    PWDATA_PAGOFP_016   /dev/rdsk/c1d223s6
  511976    56064  511976  PWDATA_PAGOFP_017    PWDATA_PAGOFP_017   /dev/rdsk/c1d224s6
  511976    56048  511976  PWDATA_PAGOFP_018    PWDATA_PAGOFP_018   /dev/rdsk/c1d225s6
  511976    56056  511976  PWDATA_PAGOFP_019    PWDATA_PAGOFP_019   /dev/rdsk/c1d226s6
  511648    56016  511648  PWDATA_PAGOFP_022    PWDATA_PAGOFP_022   /dev/rdsk/c1d228s6
  511648    56028  511648  PWDATA_PAGOFP_023    PWDATA_PAGOFP_023   /dev/rdsk/c1d229s6
  511648    56016  511648  PWDATA_PAGOFP_024    PWDATA_PAGOFP_024   /dev/rdsk/c1d330s6
   51192     5592   51195  DG_DATA_PICBDVP0009  DG_DATA_PICBDVP0009 /dev/rdsk/c1d331s6

DG_REDO01_PAGOFP
Total_MB  Free_MB  OS_MB  Name                 Failgroup            Path
   10232     7064  10233  PWREDO01_PAGOFP_001  PWREDO01_PAGOFP_001  /dev/rdsk/c1d203s6
   10232     7064  10233  PWREDO01_PAGOFP_002  PWREDO01_PAGOFP_002  /dev/rdsk/c1d204s6

DG_REDO02_PAGOFP
Total_MB  Free_MB  OS_MB  Name                 Failgroup            Path
   10232     7064  10233  PWREDO02_PAGOFP_001  PWREDO02_PAGOFP_001  /dev/rdsk/c1d205s6
   10232     7064  10233  PWREDO02_PAGOFP_002  PWREDO02_PAGOFP_002  /dev/rdsk/c1d206s6

DG_REDO03_PAGOFP
Total_MB  Free_MB  OS_MB  Name                 Failgroup            Path
   10232    10180  10233  PWREDO03_PAGOFP_001  PWREDO03_PAGOFP_001  /dev/rdsk/c1d207s6
   10232    10184  10233  PWREDO03_PAGOFP_002  PWREDO03_PAGOFP_002  /dev/rdsk/c1d208s6

FRA
Total_MB  Free_MB   OS_MB  Name       Failgroup  Path
  255824   246268  255824  PWFRA_001  PWFRA_001  /dev/rdsk/c1d201s6
  255824   246272  255824  PWFRA_002  PWFRA_002  /dev/rdsk/c1d202s6
  255824   246268  255824  PWFRA_003  PWFRA_003  /dev/rdsk/c1d332s6
  255824   246268  255824  PWFRA_004  PWFRA_004  /dev/rdsk/c1d333s6
  255824   246276  255824  PWFRA_006  PWFRA_006  /dev/rdsk/c1d334s6
  255824   246268  255824  PWFRA_005  PWFRA_005  /dev/rdsk/c1d335s6
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DG_AUDIT
Total_MB  Free_MB  OS_MB  Name       Failgroup  Path
   51192    51016  51194  DG_AUDIT1  DG_AUDIT1  AFD:DG_AUDIT1

DG_DATA
Total_MB  Free_MB   OS_MB  Name          Failgroup        Path
  204788    24672  204788  DG_DATA_0004  DG_DATA_0004     /dev/rdsk/c1d15s6
  204788    24668  204788  DG_DATA_0002  DG_DATA_0002     /dev/rdsk/c1d16s6
  204788    24664  204788  DG_DATA_0003  DG_DATA_0003     /dev/rdsk/c1d17s6
  204788    24684  204788  DG_DATA_0005  DG_DATA_0005     /dev/rdsk/c1d30s6
  204788    24680  204788  DG_DATA_0006  DG_DATA_0006     /dev/rdsk/c1d31s6
  204788    24676  204788  DG_DATA_0007  DG_DATA_0007     /dev/rdsk/c1d32s6
  204788    24680  204788  DG_DATA_0008  DG_DATA_0008     /dev/rdsk/c1d33s6
  204788    24664  204788  DG_DATA_0009  DG_DATA_0009     /dev/rdsk/c1d34s6
  204788    24676  204788  DG_DATA_0010  DG_DATA_0010     /dev/rdsk/c1d36s6
  204788    24680  204788  DG_DATA_0011  DG_DATA_0011     /dev/rdsk/c1d37s6
  204788    24668  204788  DG_DATA_0012  DG_DATA_0012     /dev/rdsk/c1d38s6
  204788    24692  204788  DG_DATA_0013  DG_DATA_0013     /dev/rdsk/c1d39s6
  204788    24688  204788  DG_DATA_0014  DG_DATA_0014     /dev/rdsk/c1d40s6
  204788    24696  204788  DG_DATA1      DG_DATA1         AFD:DG_DATA1
  204788    24656  204788  DG_DATA2      DG_DATA2         AFD:DG_DATA2
  204788    24676  204788  DG_DATA3      DG_DATA3         AFD:DG_DATA3
  204788    24672  204788  DG_DATA4      DG_DATA4         AFD:DG_DATA4
  204788    24692  204788  DG_DATA5      DG_DATA5         AFD:DG_DATA5
  204788    24688  204788  DG_DATA6      DG_DATA6         AFD:DG_DATA6
  204788    24676  204788  DG_DATA7      DG_DATA7         AFD:DG_DATA7
  204788    24688  204788  DG_DATA8      DG_DATA8         AFD:DG_DATA8

DG_OCRVOTE
Total_MB  Free_MB  OS_MB  Name         Failgroup    Path
   51192    24916  51194  DG_OCRVOTE1  DG_OCRVOTE1  AFD:DG_OCRVOTE1
   51192    24920  51194  DG_OCRVOTE2  DG_OCRVOTE2  AFD:DG_OCRVOTE2
   51192    24924  51194  DG_OCRVOTE3  DG_OCRVOTE3  AFD:DG_OCRVOTE3

DG_REDO
Total_MB  Free_MB  OS_MB  Name   Failgroup  Path
   10232     8656  10234  REDO1  REDO1      AFD:REDO1
   10232     8672  10234  REDO2  REDO2      AFD:REDO2
   10232     8656  10234  REDO3  REDO3      AFD:REDO3

FRA
Total_MB  Free_MB  OS_MB  Name  Failgroup  Path
   51192    46708  51194  FRA1  FRA1       AFD:FRA1
   51192    46740  51194  FRA2  FRA2       AFD:FRA2
   51192    46728  51194  FRA3  FRA3       AFD:FRA3

-------------------------------------------------------------------------------------------------------------------------


CCENLP PARA ELIMINAR

   INST_ID HEADER_STATUS             PATH                                     STATE         OS_MB CREATE_DA

         2 FORMER                    /dev/rdsk/c1d41s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d42s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d43s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d44s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d45s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d46s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d47s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d48s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d49s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d50s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d51s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d52s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d53s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d54s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d55s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d56s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d57s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d58s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d59s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d60s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d61s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d62s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d63s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d64s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d65s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d66s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d67s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d68s6                        NORMAL       511976 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d69s6                        NORMAL         2042 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d6s6                         NORMAL         2042 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d70s6                        NORMAL         2042 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d71s6                        NORMAL         2042 06-MAR-25
         2 FORMER                    /dev/rdsk/c1d7s6                         NORMAL         2042 06-MAR-25
         2 CANDIDATE                 /dev/rdsk/c1d72s6                        NORMAL         2042
         2 CANDIDATE                 /dev/rdsk/c1d73s6                        NORMAL         2042
         2 CANDIDATE                 /dev/rdsk/c1d74s6                        NORMAL         2042
         2 CANDIDATE                 /dev/rdsk/c1d75s6                        NORMAL        10234
         2 CANDIDATE                 /dev/rdsk/c1d76s6                        NORMAL        10234
         2 CANDIDATE                 /dev/rdsk/c1d77s6                        NORMAL        10234
         2 CANDIDATE                 /dev/rdsk/c1d78s6                        NORMAL        10234
         2 CANDIDATE                 /dev/rdsk/c1d79s6                        NORMAL        10234
         2 CANDIDATE                 /dev/rdsk/c1d80s6                        NORMAL        10234
