#!/bin/bash

# Leer el valor actual del archivo
valor_actual=$(cat /export/home/oracle12/export_CCL_PAY_TRANSACTION/numero.txt)

# Incrementar el valor
let valor_incrementado=valor_actual+1

# Mostrar el valor incrementado
echo "Valor incrementado: $valor_incrementado"

# Guardar el valor incrementado de vuelta en el archivo
echo $valor_incrementado > numero.txt

#incremetar el nombre de la particion
particion_actual=MES$valor_actual
particion_siguiente=MES$valor_incrementado
sed "s/$particion_actual/$particion_siguiente/g" /export/home/oracle12/export_CCL_PAY_TRANSACTION/Export_CCL_PAY_TRANSACTION.sh > /export/home/oracle12/export_CCL_PAY_TRANSACTION/Export_CCL_PAY_TRANSACTION.tmp && cat /export/home/oracle12/export_CCL_PAY_TRANSACTION/Export_CCL_PAY_TRANSACTION.tmp > /export/home/oracle12/export_CCL_PAY_TRANSACTION/Export_CCL_PAY_TRANSACTION.sh && rm /export/home/oracle12/export_CCL_PAY_TRANSACTION/EXPORT_P_MES.tmp
