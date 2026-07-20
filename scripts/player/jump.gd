extends StateBase
@onready var player: Player = $"../.."
var speed
var jump_force
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func _ready():
	speed = player.speed
	jump_force = player.jump_force

func _start():
	player.animation("JUMP")
	controlled_node.velocity.y = jump_force
	jump_anim()

func on_physics_process(delta):
	if controlled_node.velocity.y > 0:
		state_machine._change_to("FALL")

	if not controlled_node.is_on_floor():
		if Input.is_action_just_released("jump") and controlled_node.velocity.y < \
		jump_force / 2:
			controlled_node.velocity.y = jump_force / 2
		


	input()
	apply_gravity(delta)
	controlled_node.move_and_slide()
	
	if player.driving:
		state_machine._change_to("DRIVE")

func jump_anim():
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2(0.8, 1.2), 0.1 / 2)
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1.0, 1.0), 0.1 / 2)

func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta

func input():
	var input_axis = Input.get_axis("left", "right")
	controlled_node.velocity.x = input_axis * speed
