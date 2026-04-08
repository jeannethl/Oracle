for DAY in {1..31}
do
echo "$DAY-JAN-2024 : $(cat alert_BDVEMPP1.log | egrep "Time:" | grep -c "$DAY-JAN-2024")"
done

-------------------------------------
-- CANTIDAD DE DESCONEXIONES X DIA --
-------------------------------------
for MONTH in {1..2}
do
	for DAY in {1..31}
	do
	 echo "$DAY-FEB-2024 : $(cat alert_PAGOFP.log | egrep "Time:" | grep -c "$DAY-FEB-2024")"
	done
done
-----------------------------------------------------------------------------------------------


------------------------------------
-- DIRECCIONES IP QUE SE DESCONECTAN
------------------------------------
ggrep -A15 -A15 "Time:" alert_PAGOFP.log |grep HOST |awk {'print$3'}




-------------------
for DAY in {1..31}
do
echo "$DAY-JAN-2024 : $(cat alert_BDVNETP2.log | egrep "Time:" | grep "HOST=" | grep -c "$DAY-FEB-2024")"
done


------------------------
-- HORAS DE DESCONEXIÓN
------------------------
ggrep -A3 -B3 "Time:" alert_BDVNETP2.log | grep -i "$DAY-FEB-2024"



for MONTH in {1..2}
do
	for DAY in {1..31}
	do
	 echo " $DAY $MONTH "
	done
done



--->$DAY-$MONTH-2024 : $(cat alert_PAGOFP.log | egrep "Time:" | grep -c "$DAY-$MONTH-2024")