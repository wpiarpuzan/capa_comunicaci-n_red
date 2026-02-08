set ant 999
set ite 0 //Iteraciones inician en 0
battery set 100 //Se define la bateria 100

atget id id
getpos2 lonSen latSen


loop
wait 10
read mens
rdata mens tipo valor

inc ite //Incrementa la iteración
print ite
if (ite >= 1000) //Si se ha llegado a 1000 transmisiones el sensor se detiene
   cprint "Llego a 1000 iteraciones para sensor: " id
	stop
end

// Si desde nodo base se envia stop, se informa al nodo base que se detuvo
if (tipo=="stop")
	data mens "stop"
	send mens * valor
	cprint "Para sensor: " id
	wait 1000
	stop
end

//Envía mensaje al nodo base que tiene bateria baja
battery bat
if(bat<5)
	data mens "critico" lonSen latSen id bat
	send mens ant
end

//identifica el nodo Base para actualizar el ant, variable que será el id del nodo base
if((tipo=="hola") && (ant == 999))
   set ant valor
   data mens tipo id
   send mens * valor
end

//Retransmite el mensaje cuando llega una alerta
if(tipo=="alerta")
   send mens ant
end
delay 10

//Si cambia la temperatura, el sensor empezará a enviar mensajes de alerta
areadsensor tempSen
rdata tempSen SensTipo idSens temp

if( temp>30)
   data mens "alerta" lonSen latSen id bat
   send mens ant
end
