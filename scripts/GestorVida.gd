class_name GestorVida
extends Node
signal On_Entity_Die 

enum TipoEntidad {jugador, enemigo, objeto}

@export var NodoPadre: Node; ##Asignar el nodo padre para destruirlo al 
##llegar a cero la vida
##parte de codigo temporal

@export var vida = 10;
@export var muerto = false;

@export var tipo: TipoEntidad = TipoEntidad.objeto

## esto procesa la vida de todas las entidades 
## que tengan este componente y puedan morir
func _process(delta: float) -> void:
	isDead()

func DamageEntity(damage: int, damageTipe: TipoEntidad) -> void:
	
	print("Damage Taken");
	
	if(damageTipe != tipo):
		return
	
	vida -= damage;

func isDead() -> bool:
	if (vida <= 0): 
		muerto = true;
		print("entidad muerta:" + str(NodoPadre));
		On_Entity_Die.emit()
		#NodoPadre.queue_free() ##linea solo de prueba no permanente
		return true
	return false
