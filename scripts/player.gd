extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyotetime: Timer = $Coyotetime
@onready var arma: GunBase = $arma_base
@onready var cuchillo: MeleeAttack = $melee_attack
@onready var vida: GestorVida = $GestorVidaComponent
var can_move: bool = true

var gravity_scale = 3
var speed = 500
var jump_force = -1000
var lastDirection: GunBase.directionGun = arma.directionGun.right

## lógica
func _physics_process(delta: float) -> void:
	if can_move:
		_executePlayer(delta)

func _executePlayer(delta: float) -> void:
	var input_axis = Input.get_axis("left", "right")
	print("vida:" + str(vida.vida))
	apply_gravity(delta)
	movement(input_axis, delta)
	jump()
	weapon(input_axis)
	animWeapon(input_axis)
	air_movement(input_axis, delta)
	update_animations(input_axis)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >=0
	if just_left_edge:
		coyotetime.start()
	isPlayerDead()

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
			jump_anim()
			velocity.y = jump_force
			coyotetime.stop()
			
	elif not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < jump_force / 2:
			velocity.y = jump_force / 2

func weapon(input_axis: float):
	## disparar
	if Input.is_action_pressed("shoot"):
		if not cuchillo.in_melee_attack_area and not cuchillo.in_attack:
			arma.shoot()
		else:
			cuchillo.attack()
	
	## cambiar direccion del arma
	if input_axis != 0:
		lastDirection = arma.directionGun.left if input_axis < 0 else arma.directionGun.right
	if Input.is_action_pressed("up"):
		arma.direction = arma.directionGun.up
	elif Input.is_action_pressed("down"):
		arma.direction = arma.directionGun.down
	else:
		arma.direction = lastDirection
	
	if input_axis != 0:
		cuchillo.position = cuchillo.posLeft if input_axis < 0 else cuchillo.posRight

## animacion del arma
func animWeapon(input_axis: float):
	if input_axis != 0:
		arma.scale.x = -1 if input_axis < 0 else 1
		
	var angle: float = 0.0
	match arma.direction:
		arma.directionGun.up: ## arriba
			angle = -90
		arma.directionGun.down: ## abajo
			angle = 90
		_: ## default
			angle = 0
	arma.rotation_degrees = angle * arma.scale.x ## rotar
	
	## cuchillo
	if cuchillo.in_attack:
		arma.hide()
	else:
		arma.show()
		
	## flipear cuchillo
	if input_axis != 0:
		cuchillo.animated_sprite_2d.flip_h = true if input_axis < 0 else false

func air_movement(input_axis, delta):
	if is_on_floor():
		return
	if input_axis !=0:
		velocity.x = input_axis * speed
	else:
		velocity.x = 0

## visuales
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

##estiramiento al saltar
func jump_anim():
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2(0.8, 1.2), 0.1 / 2)
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1.0, 1.0), 0.1 / 2)
	
func enter_car():
	can_move = false
	hide()

func exit_car():
	can_move = true
	show()

func isPlayerDead() -> bool:
	if vida.muerto: queue_free();
	return false
