extends StateBase
@onready var vehicle_base: vehicle = $"../../VehicleBase"


func on_physics_process(delta):
	controlled_node.velocity.x = 0
	vehicle_base.animation("IDLE")
	if vehicle_base.DRIVING:
		state_machine._change_to("IDLE")
	if controlled_node.velocity.y > 0:
		state_machine._change_to("FALL")

	apply_gravity(delta)
	controlled_node.move_and_slide()

func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta
