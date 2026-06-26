class_name GestorVida
extends Node

enum TipoEntidad {jugador, enemigo, objeto}

@export var NodoPadre: Node; ##Asignar el nodo padre para destruirlo al 
##llegar a cero la vida
##parte de codigo temporal

@export var vida = 10;
@export var muerto = false;

@export var tipo: TipoEntidad = TipoEntidad.objeto

#func _ready() -> void:
	#
	#print(str(vida));
	#
	#pass

func DamageEntity(damage: int, damageTipe: TipoEntidad):
	
	print("Damage Taken");
	
	if(damageTipe != tipo):
		return
	
	vida -= damage;
	print("vida restante " + str(vida))
	
	pass

	if (vida <= 0): 
		muerto = true;
		print("Morido Fokin Asi muelto");
		NodoPadre.queue_free() ##linea solo de prueba no permanente
	
	pass
