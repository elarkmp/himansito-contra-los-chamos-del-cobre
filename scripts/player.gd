extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyotetime: Timer = $Coyotetime

var gravity_scale = 2
var speed = 500
var jump_force = -1000

func _physics_process(delta: float) -> void:
	var input_axis = Input.get_axis("left", "right")
	apply_gravity(delta)
	movement(input_axis, delta)
	jump()
	air_movement(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >=0
	if just_left_edge:
		coyotetime.start()

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
	if is_on_floor() or coyotetime.time_left > 0:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
			coyotetime.stop()
			
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
		
func update_animations(input_axis):
	if input_axis !=0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("Idle")
	
	if velocity.length() == 0:
		animated_sprite_2d.play("Idle")
	
	if not is_on_floor():
		if velocity.y > 0:
			animated_sprite_2d.play("fall")
		else:
			animated_sprite_2d.play("jump")
	
	
	
