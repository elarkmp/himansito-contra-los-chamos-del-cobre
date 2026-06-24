extends CharacterBody2D

var gravity_scale = 2
var speed = 500
var jump_force = -1000

func _physics_process(delta: float) -> void:
	var input_axis = Input.get_axis("left", "right")
	apply_gravity(delta)
	movement(input_axis, delta)
	jump()
	air_movement(input_axis, delta)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * gravity_scale * delta

func movement(input_axis, delta):
	if not is_on_floor():
		return
	if input_axis != 0:
		velocity.x = input_axis * speed
	else:
		velocity.x = 0

func jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
			
	elif not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < jump_force / 2:
			velocity.y = jump_force / 2

func air_movement(input_axis, delta):
	if is_on_floor():
		return
	if input_axis !=0:
		velocity.x = input_axis * speed
	else:
		velocity.x = 0
