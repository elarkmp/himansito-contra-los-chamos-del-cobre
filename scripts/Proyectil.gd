class_name Proyectil
extends RigidBody2D

@export var enTesteo = false
@export var fuerza: float = 5
@export var direccion: Vector2;

@onready var sprite: Sprite2D = $Sprite2D
@export var proyectilres: proyectil_res

func _ready() -> void:
	sprite.texture = proyectilres.textura
	
	if (enTesteo == false):
		return
	
	ImpulsarObjeto(fuerza, direccion)
	
	pass

func _process(delta: float) -> void:
	##print(str(position))
	destroy()
	pass

func destroy():
	await get_tree().create_timer(1.5).timeout
	queue_free()
	pass

func ImpulsarObjeto(fuerza: float, direccion: Vector2):
	
	var direccionReal = direccion * fuerza;
	apply_force(direccionReal)
	
	pass
