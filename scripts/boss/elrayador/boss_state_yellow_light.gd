extends StateBase
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var yellow_light: AnimatedSprite2D = $"../../yellow_light"
@onready var collision_shape_2d: CollisionShape2D = $"../../yellow_light/DamageComponent/CollisionShape2D"



func _start():
	var player = get_tree().get_first_node_in_group("player")
	animated_sprite_2d.play("YELLOW_LIGHT")
	yellow_light.global_position.x = player.global_position.x
	await get_tree().create_timer(0.8).timeout
	collision_shape_2d.disabled = false
	yellow_light.play("lighting")
	yellow_light.show()
	await get_tree().create_timer(0.5).timeout
	collision_shape_2d.disabled = true
	yellow_light.hide()
	state_machine._change_to("BossStateIdle")
