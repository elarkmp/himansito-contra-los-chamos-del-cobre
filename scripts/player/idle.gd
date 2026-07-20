extends StateBase
@onready var player: Player = $"../.."


func on_physics_process(delta):
	player.animation("IDLE")
	controlled_node.velocity.x = 0

	input()
	apply_gravity(delta)
	controlled_node.move_and_slide()
	
	if controlled_node.velocity.y > 0:
		state_machine._change_to("FALL")
		
	if player.driving:
		state_machine._change_to("DRIVE")

func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta

func input():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine._change_to("RUN")
	elif Input.is_action_pressed("jump"):
		state_machine._change_to("JUMP")
