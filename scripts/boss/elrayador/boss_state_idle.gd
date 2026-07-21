extends StateBase
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func _start():
	animated_sprite_2d.play("IDLE")
	await get_tree().create_timer(randi_range(3, 5)).timeout
	var counter = randi_range(1, 2)
	if counter == 1:
		state_machine._change_to("BLUELIGHT")
	elif counter == 2:
		state_machine._change_to("YELLOWLIGHT")
