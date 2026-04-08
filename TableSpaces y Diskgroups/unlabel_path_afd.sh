#!/bin/bash

#* *******************************************************************************
#* Autor               : Nelson Diaz, Diego Redondo - DBA TEAM - ADSI
#* Version             : 1.0
#* Fecha               : 26/06/2025
#* Ultima Modificacion : 26/06/2025 - Nelson Diaz
#* Script_name         : unlabel_path_afd.sh
#* Utilidad            : Quita las etiquetas de AFD:* en los path a nivel de ASM.
#* *******************************************************************************

# OBTENER LOS NOMBRE DE LOS PATH AFD

PATH_NAME=$(sqlplus -S / as sysasm <<EOF
SET HEAD OFF
SELECT PATH
FROM v\$asm_disk
WHERE header_status = 'FORMER'
AND PATH LIKE 'AFD:%';
EXIT;
EOF
)

for i in ${PATH_NAME[@]}
do
# CAMBIAR EL NOMBRE A NIVEL DE ASM
PATH_AFD=$(echo $i | awk -F':' '{print $2}')
echo "asmcmd afd_unlabel '${PATH_AFD}'" | sh
done

echo -e "Finish!\n"

# [AFD:DISK1,AFD:DISK2,...]

