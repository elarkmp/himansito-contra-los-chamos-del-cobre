extends StateBase
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func _start():
	animated_sprite_2d.play("ALERT")
	await get_tree().create_timer(2).timeout
	TextoEnPantalla.text_center("EL RAYADOR", 1)
	TextoEnPantalla.text_down("(tira rayos)", 1)
	await get_tree().create_timer(1).timeout
	state_machine._change_to("BossStateIdle")
	
