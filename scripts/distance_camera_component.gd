extends Node2D
var camara: Camera2D
var camara_initial_position: Vector2
@export var vehicle_base : vehicle
@onready var distancia_1: RayCast2D = $distancia1
@onready var distancia_2: RayCast2D = $distancia2
@onready var distancia_3: RayCast2D = $distancia3

func _ready() -> void:
	camara = vehicle_base.camara
	set_physics_process(false)
	#camara_initial_position = Player.camera.position
	
func _physics_process(delta: float) -> void:
	if camara == null: return
	if vehicle_base.driving:
		if distancia_1.is_colliding():
			camara.zoom = Vector2(0.9, 0.9)
			camara.position = camara_initial_position
		elif distancia_2.is_colliding():
			camara.zoom = Vector2(0.7, 0.7)
			camara.position = Vector2(0.0, 45.0)
		elif distancia_3.is_colliding():
			camara.zoom = Vector2(0.6, 0.6)
			camara.position = Vector2(0.0, 70.0)
	else:
		camara.zoom = Vector2(0.9, 0.9)
		camara.position = camara_initial_position
