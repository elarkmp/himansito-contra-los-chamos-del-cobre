extends Area2D
const SPEED = 1500
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var proyectilres: proyectil_res
var impulsar_var:bool = false

func _ready() -> void:
	sprite_2d.texture = proyectilres.textura
	destroy()
	
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta

func destroy():
	await get_tree().create_timer(1.5).timeout
	queue_free()
	pass
