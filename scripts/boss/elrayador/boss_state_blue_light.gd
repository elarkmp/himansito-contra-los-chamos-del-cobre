extends StateBase
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var blue_light: AnimatedSprite2D = $"../../blue_light"
@onready var collision_shape_2d: CollisionShape2D = $"../../blue_light/DamageComponent/CollisionShape2D"



func _start():
	animated_sprite_2d.play("BLUE_LIGHT")
	await get_tree().create_timer(1.2).timeout
	collision_shape_2d.disabled = false
	blue_light.play("lighting")
	blue_light.show()
	await get_tree().create_timer(0.2).timeout
	collision_shape_2d.disabled = true
	blue_light.hide()
	state_machine._change_to("IDLE")
