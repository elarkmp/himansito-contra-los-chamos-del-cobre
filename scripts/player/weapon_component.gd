extends Node
@onready var arma: GunBase = $"../arma_base"
@onready var cuchillo: MeleeAttack = $"../melee_attack"
@onready var player: Player = $".."
var agachado: bool = false
var lastDirection: GunBase.directionGun = arma.directionGun.right


func _physics_process(_delta: float) -> void:
	if !player.can_move: return
	var input_axis = Input.get_axis("left", "right")
	weapon(input_axis)
	animWeapon(input_axis)

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
		if !player.is_on_floor():
			agachado = false
			arma.direction = arma.directionGun.down
		else:
			agachado = true
			arma.direction = lastDirection
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
		arma.directionGun.down:
			if !agachado: ## abajo
				angle = 90
			else:
				angle = 0.0
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
