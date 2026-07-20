extends StateBase
@onready var player: Player = $"../.."

var coyote_timer
var speed

func _start():
	coyote_timer = player.coyote_time
	speed = player.speed
	player.animation("FALL")

func on_physics_process(delta):

	if controlled_node.velocity.y == 0:
		state_machine._change_to("IDLE")

	input()
	apply_gravity(delta)
	controlled_node.move_and_slide()
	
	if player.driving:
		state_machine._change_to("DRIVE")

func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta

func input():
	var input_axis = Input.get_axis("left", "right")
	controlled_node.velocity.x = input_axis * speed
