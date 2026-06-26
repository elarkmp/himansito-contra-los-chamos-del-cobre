extends RigidBody2D

@export var enTesteo = false
@export var fuerza: float = 5
@export var direccion: Vector2;

func _ready() -> void:
	
	if (enTesteo == false):
		return
	
	ImpulsarObjeto(fuerza, direccion)
	
	pass

#func _process(delta: float) -> void:
	#
	#print(str(position))
	#
	#pass


func ImpulsarObjeto(fuerza: float, direccion: Vector2):
	
	var direccionReal = direccion * fuerza;
	apply_force(direccionReal)
	
	pass
