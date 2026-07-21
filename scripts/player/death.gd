extends StateBase

var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
@export var knockback_direction = Vector2(-1, -1).normalized()
@export var knockback_force: float = 800.0
@export var knockback_time: float = 0.3

func _start():
	_apply_knockback(knockback_direction, knockback_force, knockback_time)
	
func on_physics_process(delta):
	if knockback_timer > 0.0:
		knockback_timer -= delta
		if knockback_timer <= 0.0:
			controlled_node.velocity = Vector2.ZERO
			await get_tree().create_timer(2.0).timeout
			controlled_node.queue_free()
			
	apply_gravity(delta)
	controlled_node.move_and_slide()

func _apply_knockback(direction: Vector2, force: float, knockback_duration: float):
	controlled_node.velocity = direction * force
	knockback_timer = knockback_duration

func apply_gravity(delta):
	if not controlled_node.is_on_floor():
		controlled_node.velocity += controlled_node.get_gravity() * 3 * delta
