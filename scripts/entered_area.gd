extends Area2D
@export var vehicle_base: vehicle
var in_vehicle_area: bool
var body_player

func _on_body_entered(body: Node2D) -> void:
	in_vehicle_area = true
	body_player = body

func _on_body_exited(_body: Node2D):
	in_vehicle_area = false

#el jugador entra
func _input(_event: InputEvent) -> void:
	if in_vehicle_area and not vehicle_base.DRIVING:
		if Input.is_action_just_pressed("interactuar"):
			vehicle_base.enter_vehicle(body_player)
			body_player.drive(true)
	elif in_vehicle_area and vehicle_base.DRIVING:
		if Input.is_action_just_pressed("interactuar"):
			vehicle_base.exit_vehicle()
			body_player.drive(false)
