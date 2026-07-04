extends Area2D
@onready var vehicle_base: vehicle = $".."
var in_vehicle_area: bool
var body_player

func _on_body_entered(body: Node2D) -> void:
	in_vehicle_area = true
	body_player = body

func _on_body_exited(body: Node2D) -> void:
	in_vehicle_area = false

#el jugador entra
func _input(event: InputEvent) -> void:
	if in_vehicle_area and not vehicle_base.driving:
		if Input.is_action_just_pressed("interactuar"):
			if body_player.has_method("enter_car"):
				_entrar()
	elif in_vehicle_area and vehicle_base.driving:
		if Input.is_action_just_pressed("interactuar"):
			if body_player.has_method("exit_car"):
				_salir()

func _entrar():
	body_player.enter_car()
	vehicle_base.driving = true

func _salir():
	body_player.exit_car()
	vehicle_base.driving = false
