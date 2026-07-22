extends Node2D
var bullet = preload("res://Escenas/Entidades/car_bullet.tscn")
@onready var vehicle_base: vehicle = $".."
var _canShoot: bool = true
var _cooldown: float = 0.0
var fireRate: float = 0.1
var force: float = 110
@onready var muzzle: Marker2D = $Marker2D
var aim_value: = 9
var aim_mode: = "up"
var moving: bool = true
var moving_cooldown: float = 0.0
@export var moving_value: float = 0.034

const ARRIBA := [
	deg_to_rad(180),
	deg_to_rad(202.5),
	deg_to_rad(225),
	deg_to_rad(247.5),
	deg_to_rad(270),
	deg_to_rad(292.5),
	deg_to_rad(315.0),
	deg_to_rad(337.5),
	deg_to_rad(360),
]
const ABAJO := [
	deg_to_rad(-180),
	deg_to_rad(-202.5),
	deg_to_rad(-225),
	deg_to_rad(-247.5),
	deg_to_rad(-270),
	deg_to_rad(-292.5),
	deg_to_rad(-315.0),
	deg_to_rad(-337.5),
	deg_to_rad(-360),
]

#region shoot
func _process(delta: float) -> void:
	if not _canShoot:
		_cooldown -= delta
		if _cooldown <= 0.0:
			_canShoot = true

	if not moving:
		moving_cooldown -= delta
		if moving_cooldown <= 0.0:
			moving = true
	
	if vehicle_base.DRIVING:
		if Input.is_action_pressed("shoot"):
			shoot()
		aiming()

func shoot() -> bool:
	if not _canShoot:
		#print("no se puede")
		return false
	
	_canShoot = false
	_cooldown = fireRate

	var instance = bullet.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = muzzle.global_position
	instance.rotation = rotation
	return true
#endregion

func aiming():
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	
	if moving:
		if left:
			aim_value -=1
		if right:
			aim_value +=1
		moving = false
		moving_cooldown = moving_value

	aim_value = clamp(aim_value,0,8)

	if Input.is_action_just_pressed("down"):
		aim_mode = "down"
	if Input.is_action_just_pressed("up"):
		aim_mode = "up"

	if aim_mode == "down":
		rotation = ABAJO[aim_value]
	elif aim_mode == "up":
		rotation = ARRIBA[aim_value]
