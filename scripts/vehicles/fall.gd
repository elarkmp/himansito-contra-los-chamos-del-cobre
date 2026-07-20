extends StateBase
@onready var vehicle_base: vehicle = $"../../VehicleBase"
var speed

func _start():
	speed = vehicle_base.speed


func on_physics_process(delta):
	vehicle_base.animation("FALL")
	if controlled_node.velocity.y == 0:
		if vehicle_base.DRIVING:
			state_machine._change_to("IDLE")
		else:
			state_machine._change_to("SLEEP")


	if vehicle_base.DRIVING:
		input()
	apply_gravity(delta)
	controlled_node.move_and_slide()

func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta

func input():
	var input_axis = Input.get_axis("left", "right")
	controlled_node.velocity.x = input_axis * speed
