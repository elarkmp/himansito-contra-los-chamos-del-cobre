extends Area2D
class_name MeleeAttack
var in_melee_attack_area: bool
var in_attack: bool
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $DamageComponent/CollisionShape2D


func attack():
	if not in_attack:
		in_attack = true
		collision_shape_2d.disabled = false
		animated_sprite_2d.show()
		animated_sprite_2d.play("cuchillazo")
		await get_tree().create_timer(0.5).timeout
		collision_shape_2d.disabled = true
		animated_sprite_2d.hide()
		in_attack = false

func _on_body_entered(body: Node2D) -> void:
	in_melee_attack_area = true

func _on_body_exited(body: Node2D) -> void:
	in_melee_attack_area = false
