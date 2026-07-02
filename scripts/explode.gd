extends Node
@onready var bullet: Proyectil = $".."



func _on_damage_component_body_entered(body: Node2D) -> void:
	bullet.queue_free()
