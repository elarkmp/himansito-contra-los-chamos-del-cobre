extends Node
@export var vehicle_base : vehicle

@export var speed:float = 450.0
@export var fly_force:float = 400.0
@export var gravity_scale: float = 3.0
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
var driving
var conductor
var tween

enum STATE {
	IDLE,
	RUN,
	FLY_UP,
	FLY_DOWN,
	FALL,
}

var current_state : STATE = STATE.IDLE

func _physics_process(delta: float) -> void:
	
	driving = vehicle_base.driving
	conductor = vehicle_base.conductor
	
	if conductor == null:
		driving = false
		
	var input_axis = Input.get_axis("left", "right")
	if driving:
		conductor.global_position = vehicle_base.global_position
	
	if driving:
		match current_state:
			STATE.IDLE:
				vehicle_base.velocity.x = 0
				if not vehicle_base.is_on_floor():
					if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
						current_state = STATE.RUN
					elif Input.is_action_pressed("down"):
						current_state = STATE.FLY_DOWN
				if Input.is_action_pressed("up"):
						current_state = STATE.FLY_UP
			STATE.RUN:
				vehicle_base.velocity.x = input_axis * speed
				if Input.is_action_just_pressed("up"):
					current_state = STATE.FLY_UP
				elif Input.is_action_just_pressed("down"):
					current_state = STATE.FLY_DOWN
				elif not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
					current_state = STATE.IDLE
			STATE.FLY_UP:
				vehicle_base.velocity.x = input_axis * speed
				vehicle_base.velocity.y = fly_force * -1
				if not Input.is_action_pressed("up"):
					current_state = STATE.IDLE
					vehicle_base.velocity.y = 0
				elif Input.is_action_pressed("down"):
					current_state = STATE.FLY_DOWN
			STATE.FLY_DOWN:
				vehicle_base.velocity.x = input_axis * speed
				vehicle_base.velocity.y = fly_force * 1
				if not Input.is_action_pressed("down"):
					current_state = STATE.IDLE
					vehicle_base.velocity.y = 0
				elif Input.is_action_pressed("up"):
					current_state = STATE.FLY_UP
	
	if not driving:
		if not vehicle_base.is_on_floor():
			apply_gravity(delta)
			current_state = STATE.FALL
		else:
			current_state = STATE.IDLE
		vehicle_base.velocity.x = 0.0
	
	update_animations()
	vehicle_base.move_and_slide()
	
func apply_gravity(delta):
	if not vehicle_base.is_on_floor():
		vehicle_base.velocity += vehicle_base.get_gravity() * gravity_scale * delta
		
func update_animations():
	match current_state:
		STATE.IDLE:
			tween = create_tween()
			tween.tween_property(animated_sprite_2d, "rotation_degrees", 0.0, 0.2 )
			if vehicle_base.is_on_floor():
				animated_sprite_2d.play("Idle")
			else:
				animated_sprite_2d.play("jump")
		STATE.FLY_UP:
			if driving:
				animated_sprite_2d.play("jump")
		STATE.FALL:
			animated_sprite_2d.play("fall")
			if vehicle_base.is_on_floor():
				current_state = STATE.IDLE
	if driving:
		if vehicle_base.velocity.x > 0:
			tween = create_tween()
			tween.tween_property(animated_sprite_2d, "rotation_degrees", 10.0, 0.5 )
		elif vehicle_base.velocity.x < 0:
			tween = create_tween()
			tween.tween_property(animated_sprite_2d, "rotation_degrees", -10.0, 0.5 )
