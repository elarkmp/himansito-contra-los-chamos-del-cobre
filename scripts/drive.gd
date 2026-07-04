extends Node
@export var vehicle_base : vehicle

@export var speed:float = 450.0
@export var jump_force:float = -850.0
@export var gravity_scale:float = 3
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
var driving
var conductor

enum STATE {
	IDLE,
	RUN,
	JUMP,
	FALL,
}


var current_state : STATE = STATE.IDLE

func _physics_process(delta: float) -> void:
	var input_axis = Input.get_axis("left", "right")
	if driving:
		conductor.global_position = vehicle_base.global_position
	
	match current_state:
		STATE.IDLE:
			vehicle_base.velocity.x = 0
			if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				current_state = STATE.RUN
			elif Input.is_action_just_pressed("jump"):
				current_state = STATE.JUMP
			elif vehicle_base.velocity.y > 0:
				current_state = STATE.FALL
		STATE.RUN:
			vehicle_base.velocity.x = input_axis * speed
			if Input.is_action_just_pressed("jump"):
				current_state = STATE.JUMP
			elif not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
				current_state = STATE.IDLE
		STATE.JUMP:
			vehicle_base.velocity.x = input_axis * speed
			if vehicle_base.is_on_floor() and vehicle_base.velocity.y >= 0:
				vehicle_base.velocity.y = jump_force
				
			if vehicle_base.velocity.y > 0:
				current_state = STATE.FALL
		STATE.FALL:
			vehicle_base.velocity.x = input_axis * speed
			if vehicle_base.is_on_floor() and vehicle_base.velocity.y >= 0:
				current_state = STATE.IDLE

	driving = vehicle_base.driving
	conductor = vehicle_base.conductor


	if not driving:
		current_state = STATE.IDLE

	apply_gravity(delta)
	vehicle_base.move_and_slide()
	update_animations()

func apply_gravity(delta):
	if not vehicle_base.is_on_floor():
		vehicle_base.velocity += vehicle_base.get_gravity() * gravity_scale * delta
		
func update_animations():
	match current_state:
		STATE.IDLE:
				animated_sprite_2d.play("Idle")
		STATE.RUN:
			if driving:
				animated_sprite_2d.play("run")
		STATE.JUMP:
			if driving:
				animated_sprite_2d.play("jump")
		STATE.FALL:
			if driving:
				animated_sprite_2d.play("fall")
			
