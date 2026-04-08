************AGREAGAR DISCOS EN LINUX CLUSTER******************************************

*** ES SUMAMENTE DELICADO *****
*** LEER CUIDADOSAMENTENTE *****
*** SI ESTA MOLESTO, O NO ESTA DISPUESTO HACERLO...   NO LO REALICE *****


***************************************************************************************
PASOS

1. Validar que todos los discos tengan el mismo nombre en los 2 o 3 servidores.

EXISTEN DOS FORMAS 

2. Desde un archivo creado 

2.1.1 Agregar los nombre de los discos que le dieron en un archivo

ruta

/home/oracle19/scripts/discos

vi discos_redo.txt

asm_108
asm_109
asm_110
asm_111
asm_112
asm_113

asm_120
asm_121
asm_122

2.1.2 Para poder realizar este comando debe ser root y entrar a la ruta de la carpeta

for i in $(cat discos_d.txt | awk '{print$1}') ; do multipath -ll |grep $i; done

asm_108 (360000970000220002339533030333634) dm-185 EMC,SYMMETRIX
asm_109 (360000970000220002339533030333635) dm-186 EMC,SYMMETRIX
asm_110 (360000970000220002339533030333636) dm-187 EMC,SYMMETRIX
asm_111 (360000970000220002339533030333637) dm-188 EMC,SYMMETRIX
asm_112 (360000970000220002339533030333638) dm-189 EMC,SYMMETRIX
asm_113 (360000970000220002339533030333639) dm-190 EMC,SYMMETRIX

2.1.3 Validar en los otros nodos 

ssh plbdtrz02 for i in $(cat discos_d.txt | awk '{print$1}') ; do multipath -ll |grep $i; done



----- OTRA FORMA DE VALIDAR MULTIPATH

2.2 Entrar en Root 

2.2.1 Validar si existen
lsblk -fm

2.2.2 Validar si tiene la misma etiqueta en todos nodos

--- En el nodo en el que estas 
multipath -ll | grep asm_8

--- En el otros 
ssh plbdcb01 multipath -ll | grep asm_9


3. Validar las particiones 

lsblk -fm | more
lsblk -fm | grep DISK_ASM_DATA
lsblk -fm | grep -i asm_80

NOTA:
SI TODOS ESTAN PARTICIONADOS IR AL PASO 4 y SI LO DISCOS SE PUEDEN AGREGAR SIN PARTICION IR AL PASO 5


************************************************************************

 DEBE SER ROOT en los siguientes pasos

************************************************************************

4. Particionar los discos

echo -e "o\nn\np\n1\n\n\nw" | fdisk lsblk -fm asm_108
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/mapper/sdd
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/mapper/asm_141
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/mapper/asm_142
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/mapper/asm_143
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/mapper/asm_144
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/mapper/asm_145




En todos los nodos realizar refrescamiento de particiones por disco agregado

/sbin/partprobe /dev/mapper/asm_140
/sbin/partprobe /dev/mapper/asm_141
/sbin/partprobe /dev/mapper/asm_142
/sbin/partprobe /dev/mapper/asm_143
/sbin/partprobe /dev/mapper/asm_144
/sbin/partprobe /dev/mapper/asm_145

/usr/sbin/oracleasm createdisk DISK_ASM00140 /dev/mapper/asm_140p1
/usr/sbin/oracleasm createdisk DISK_ASM00141 /dev/mapper/asm_141p1
/usr/sbin/oracleasm createdisk DISK_ASM00142 /dev/mapper/asm_142p1
/usr/sbin/oracleasm createdisk DISK_ASM00143 /dev/mapper/asm_143p1
/usr/sbin/oracleasm createdisk DISK_ASM00144 /dev/mapper/asm_144p1
/usr/sbin/oracleasm createdisk DISK_ASM00145 /dev/mapper/asm_145p1

/sbin/partprobe /dev/mapper/asm_49p1


****************************************************************************

5. Creacion de discos a nivel oracleasm (SOLO NODO 1)

SOLO NODO 1*************************************************

/usr/sbin/oracleasm createdisk DISK_DATA021 /dev/mapper/asm_44p1



/usr/sbin/oracleasm createdisk DISK_ASM00124 /dev/mapper/asm_124p1
/usr/sbin/oracleasm createdisk DISK_ASM00125 /dev/mapper/asm_125p1
/usr/sbin/oracleasm createdisk DISK_ASM00126 /dev/mapper/asm_126p1
/usr/sbin/oracleasm createdisk DISK_ASM00127 /dev/mapper/asm_127p1
/usr/sbin/oracleasm createdisk DISK_ASM00128 /dev/mapper/asm_128p1



*****************************************************************************

Ejecutar en todos los nodos

/usr/sbin/oracleasm scandisks
/usr/sbin/oracleasm listdisks



POR SI TE EQUIVOCAS 
------------------------------------------------------------------------------------------------
/usr/sbin/oracleasm renamedisk -f DISCO_VIEJO DISCO_NUEVO ---RENOMBRAR EL DISCO
/usr/sbin/oracleasm deletedisk DISCO_VIEJO ---ELIMINAR EL DISCO

--- AGREGAR Y HACER EL PROCEDIMIENRO DE NUEVO 
/sbin/partprobe /dev/mapper/DISCO_NUEVO 
/usr/sbin/oracleasm scandisks
/usr/sbin/oracleasm listdisks
/sbin/partprobe /dev/mapper/DISCO_NUEVO

