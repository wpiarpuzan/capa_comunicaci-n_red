atget id id

data p "hola" id id
send p

loop
read mens
rdata mens tipo valor1 valor2 idSensor bateria
if( tipo == "alerta")
   cprint "Alerta en: Sensor" idSensor ", longitud" valor1 ", latitud: " valor2 ", bat:" bateria
end

if(tipo == "critico")
	cprint "Nodo" idSensor "descargado. bat:" bateria ", longitud:" valor1 ", latitud: " valor2
	data p "stop"	
	send p
	wait 1000
	stop
end

wait 10