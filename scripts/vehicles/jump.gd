extends StateBase
@onready var vehicle_base: vehicle = $"../../VehicleBase"
var speed
var jump_force

func _ready():
	speed = vehicle_base.speed
	jump_force = vehicle_base.jump_force


func on_physics_process(delta):
	vehicle_base.animation("JUMP")
	if controlled_node.velocity.y > 0:
		state_machine._change_to("FALL")
	if controlled_node.is_on_floor() and controlled_node.velocity.y >= 0:
		controlled_node.velocity.y = jump_force

	input()
	apply_gravity(delta)
	controlled_node.move_and_slide()
	
	if not vehicle_base.DRIVING:
		state_machine._change_to("SLEEP")
	
func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta

func input():
	var input_axis = Input.get_axis("left", "right")
	controlled_node.velocity.x = input_axis * speed
