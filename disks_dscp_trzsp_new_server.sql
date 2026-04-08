disks dscp trzsp new server


set lines 400
COLUMN header_status FORMAT a25
COLUMN path FORMAT a40
COLUMN name FORMAT a20
SELECT group_number, inst_id, header_status, path, state, OS_MB, create_date 
FROM gv$asm_disk
WHERE header_status = 'MEMBER'
ORDER BY path;




DATA_DCSP
 /dev/oracleasm/disks/DISK_ASM0051
 /dev/oracleasm/disks/DISK_ASM0052
 /dev/oracleasm/disks/DISK_ASM0053
 /dev/oracleasm/disks/DISK_ASM0054
 /dev/oracleasm/disks/DISK_ASM0055
 /dev/oracleasm/disks/DISK_ASM0056
 /dev/oracleasm/disks/DISK_ASM0057
 /dev/oracleasm/disks/DISK_ASM0058
 /dev/oracleasm/disks/DISK_ASM0059
 /dev/oracleasm/disks/DISK_ASM0060
 /dev/oracleasm/disks/DISK_ASM0061
 /dev/oracleasm/disks/DISK_ASM0062
 /dev/oracleasm/disks/DISK_ASM0063
 /dev/oracleasm/disks/DISK_ASM0064
 /dev/oracleasm/disks/DISK_ASM0065
 /dev/oracleasm/disks/DISK_ASM0066
 /dev/oracleasm/disks/DISK_ASM0081
 /dev/oracleasm/disks/DISK_ASM0082
 /dev/oracleasm/disks/DISK_ASM0083
 /dev/oracleasm/disks/DISK_ASM0084

FRA_DCSP

 /dev/oracleasm/disks/DISK_ASM0085
 /dev/oracleasm/disks/DISK_ASM0086

REDO01_DCSP
 /dev/oracleasm/disks/DISK_ASM0073
 /dev/oracleasm/disks/DISK_ASM0074

REDO02_DCSP
 /dev/oracleasm/disks/DISK_ASM0075
 /dev/oracleasm/disks/DISK_ASM0076




 DATA_TRZSP
/dev/oracleasm/disks/DISK_ASM0001
/dev/oracleasm/disks/DISK_ASM0002
/dev/oracleasm/disks/DISK_ASM0003
/dev/oracleasm/disks/DISK_ASM0004
/dev/oracleasm/disks/DISK_ASM0005
/dev/oracleasm/disks/DISK_ASM0006
/dev/oracleasm/disks/DISK_ASM0007
/dev/oracleasm/disks/DISK_ASM0008
/dev/oracleasm/disks/DISK_ASM0009
/dev/oracleasm/disks/DISK_ASM0010
/dev/oracleasm/disks/DISK_ASM0011
/dev/oracleasm/disks/DISK_ASM0012
/dev/oracleasm/disks/DISK_ASM0013
/dev/oracleasm/disks/DISK_ASM0014
/dev/oracleasm/disks/DISK_ASM0015
/dev/oracleasm/disks/DISK_ASM0016
/dev/oracleasm/disks/DISK_ASM0017
/dev/oracleasm/disks/DISK_ASM0018
/dev/oracleasm/disks/DISK_ASM0019
/dev/oracleasm/disks/DISK_ASM0020
/dev/oracleasm/disks/DISK_ASM0021
/dev/oracleasm/disks/DISK_ASM0022
/dev/oracleasm/disks/DISK_ASM0023
/dev/oracleasm/disks/DISK_ASM0024
/dev/oracleasm/disks/DISK_ASM0025
/dev/oracleasm/disks/DISK_ASM0026
/dev/oracleasm/disks/DISK_ASM0027
/dev/oracleasm/disks/DISK_ASM0028
/dev/oracleasm/disks/DISK_ASM0029
/dev/oracleasm/disks/DISK_ASM0030
/dev/oracleasm/disks/DISK_ASM0031
/dev/oracleasm/disks/DISK_ASM0032
/dev/oracleasm/disks/DISK_ASM0033
/dev/oracleasm/disks/DISK_ASM0034
/dev/oracleasm/disks/DISK_ASM0035
/dev/oracleasm/disks/DISK_ASM0036
/dev/oracleasm/disks/DISK_ASM0037
/dev/oracleasm/disks/DISK_ASM0038
/dev/oracleasm/disks/DISK_ASM0039
/dev/oracleasm/disks/DISK_ASM0040
/dev/oracleasm/disks/DISK_ASM0041
/dev/oracleasm/disks/DISK_ASM0042
/dev/oracleasm/disks/DISK_ASM0043
/dev/oracleasm/disks/DISK_ASM0044
/dev/oracleasm/disks/DISK_ASM0045
/dev/oracleasm/disks/DISK_ASM0046

FRA_TRZSP
 /dev/oracleasm/disks/DISK_ASM0047
 /dev/oracleasm/disks/DISK_ASM0048
 /dev/oracleasm/disks/DISK_ASM0049
 /dev/oracleasm/disks/DISK_ASM0050

REDO01_TRZSP
/dev/oracleasm/disks/DISK_ASM0067
/dev/oracleasm/disks/DISK_ASM0068
/dev/oracleasm/disks/DISK_ASM0069

REDO02_TRZSP
 /dev/oracleasm/disks/DISK_ASM0070
 /dev/oracleasm/disks/DISK_ASM0071
 /dev/oracleasm/disks/DISK_ASM0072




MGMT

 /dev/oracleasm/disks/DISK_ASM0079
 /dev/oracleasm/disks/DISK_ASM0080



OCRVOTE

 /dev/oracleasm/disks/DISK_ASM0077
 /dev/oracleasm/disks/DISK_ASM0078















