extends StateBase
@onready var vehicle_base: vehicle = $"../../VehicleBase"
@onready var entered_area: Area2D = $"../../VehicleBase/Entered_area"
@onready var animaciones: AnimatedSprite2D = $"../../VehicleBase/animaciones"

func _start():
	vehicle_base.animation("EXPLODE")
	animaciones.animation_finished.connect(_on_animaciones_animation_finished)

func _on_animaciones_animation_finished() -> void:
	vehicle_base.explotion = true
	controlled_node.queue_free()
