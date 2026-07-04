extends Node
@onready var bullet

func _ready() -> void:
	bullet = get_parent()



func _on_damage_component_body_entered(body: Node2D) -> void:
	bullet.queue_free()
