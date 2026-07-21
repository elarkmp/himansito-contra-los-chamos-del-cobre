extends StateBase
@onready var collision_shape_2d: CollisionShape2D = $"../../detector_area/CollisionShape2D"
var detectado

func _on_detector_area_body_entered(_body: Node2D) -> void:
	collision_shape_2d.disabled = true
	if not detectado:
		state_machine._change_to("ALERT")
	detectado = true
