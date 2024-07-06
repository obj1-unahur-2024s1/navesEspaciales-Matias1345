class Nave{
	var velocidad
	var direccion
	var combustibleEnLts
	
	method acelerar(valor){
		velocidad = 100000.min(velocidad + valor)
	}
	
	method desacelerar(valor){
		velocidad = 0.max(velocidad - valor)
	}
	
	method irHaciaElSol(){
		direccion = 10
	}
	
	method escaparDelSol(){
		direccion = -10
	}
	
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	
	method alejarseUnPocoDelSol(){
		direccion = -10.max(direccion - 1)
	}
	
	method cargarCombustible(cantidad){
		combustibleEnLts = combustibleEnLts + cantidad
	}
	
	method descargarCombustible(cantidad){
		combustibleEnLts = combustibleEnLts - cantidad
	}
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method estaTranquila() = combustibleEnLts >= 4000 and velocidad <= 12000 and self.condicionAdicional()
	
	method condicionAdicional() = true
	
	//method estaTranquila2() = combustibleEnLts >= 4000 and velocidad <= 12000
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	
	method escapar()
	
	method avisar()
	
	method estaDeRelajo() = self.estaTranquila() and self.tenerPocaActividad()
	
	method tenerPocaActividad()
}

class NaveBaliza inherits Nave{
	var baliza
	var contCambios = 0
	
	method cambiarColorDeBaliza(colorNuevo){
		baliza = colorNuevo
		contCambios = contCambios + 1
	}
	
	override method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}	
	
	override method condicionAdicional() = baliza != "rojo"	
	
	//override method estaTranquila2() = super() and baliza != "rojo"	
	
	override method escapar(){
		self.irHaciaElSol()
	}
	
	override method avisar(){
		self.cambiarColorDeBaliza("rojo")
	}
	
	override method tenerPocaActividad() = contCambios == 0
}

class NavePasajeros inherits Nave{
	var pasajeros
	var racionesComida
	var racionesBebida
	var contRacionesComidasServidas
	
	method cargarComida(cantidad){
		racionesComida = racionesComida + cantidad
	}
	
	method descargarComida(cantidad){
		racionesComida = racionesComida - cantidad
	}
	
	method cargarBebida(cantidad){
		racionesBebida = racionesBebida + cantidad
	}
	
	method descargarBebida(cantidad){
		racionesBebida = racionesBebida - cantidad
	}
	
	override method prepararViaje(){
		self.cargarComida(4 * pasajeros)
		self.cargarBebida(6 * pasajeros)		
		self.acercarseUnPocoAlSol()
	}
	
	override method escapar(){
		velocidad = velocidad * 2
	}
	
	override method avisar(){
		racionesComida = racionesComida - (pasajeros)	
		racionesBebida = racionesBebida + (pasajeros * 2)	
		contRacionesComidasServidas = contRacionesComidasServidas + pasajeros
	}
	
	override method tenerPocaActividad() = contRacionesComidasServidas < 50
}

class NaveCombate inherits Nave{
	var estaVisible
	var misilesDesplegados
	const mensajesEmitidos = []
	
	method ponerseVisible(){
		estaVisible = true
	}
	
	method ponerseInvisible(){
		estaVisible = false
	}
	
	method estaInvisible() = !estaVisible
	
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	
	method replegarMisiles(){
		misilesDesplegados = false
	}
	
	method misilesDesplegados() = misilesDesplegados
	
	method emitirMensaje(mensaje){mensajesEmitidos.add(mensaje)}
	
	method mensajesEmitidos() = mensajesEmitidos
	
	method primerMensajeEmitido() = mensajesEmitidos.first()
	
	method ultimoMensajeEmitido() = mensajesEmitidos.last()
	
	method esEscueta() = mensajesEmitidos.all({m => !(m.size() > 30)})
	
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	
	override method condicionAdicional() = !self.misilesDesplegados()
	
	override method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	
	override method avisar(){
		self.emitirMensaje("Amenaza recibida")
	}
	
	override method tenerPocaActividad() = self.esEscueta()
}

class NaveHospital inherits NavePasajeros{
	var quirofanosPreparados
	
	method prepararQuirofanos(){
		quirofanosPreparados = true
	}
	
	override method condicionAdicional() = !quirofanosPreparados
	
	override method recibirAmenaza(){
		super()
		self.prepararQuirofanos()
	}
}

class NaveCombateSigilosa inherits NaveCombate{
	override method condicionAdicional() = super() and !self.estaInvisible()
	
	override method escapar(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}



