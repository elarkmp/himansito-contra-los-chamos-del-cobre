extends StateBase
@onready var vehicle_base: vehicle = $"../../VehicleBase"
var speed
var speed_fly
var tween : Tween
@onready var animaciones: AnimatedSprite2D = $"../../VehicleBase/animaciones"

func _start():
	speed = vehicle_base.speed
	speed_fly = vehicle_base.speed_fly


func on_physics_process(_delta):
	if not vehicle_base.DRIVING:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(animaciones, "rotation_degrees", 0.0, 0.2)
		state_machine._change_to("SLEEP")
		return

	update_animations()
	input()
	controlled_node.move_and_slide()

func input():
	var input_axis = Input.get_axis("left", "right")
	controlled_node.velocity.x = input_axis * speed
	
	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		tween = create_tween()
		tween.tween_property(animaciones, "rotation_degrees", 0.0, 0.2)

	if not Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		controlled_node.velocity.y = 0.0
	elif Input.is_action_pressed("up"):
		controlled_node.velocity.y = speed_fly * 1
	elif Input.is_action_pressed("down"):
		controlled_node.velocity.y = speed_fly * -1

func update_animations():
	if controlled_node.is_on_floor():
		vehicle_base.animation("IDLE")
	else:
		vehicle_base.animation("JUMP")

func _input(_event: InputEvent) -> void:
	if not vehicle_base.DRIVING: return
	if Input.is_action_just_pressed("right"):
		tween = create_tween()
		tween.tween_property(animaciones, "rotation_degrees", 10.0, 0.5 )
	if Input.is_action_just_pressed("left"):
		tween = create_tween()
		tween.tween_property(animaciones, "rotation_degrees", -10.0, 0.5 )
