extends Node2D
var bullet = preload("res://Escenas/Entidades/car_bullet.tscn")
@onready var vehicle_base: vehicle = $".."
var _canShoot: bool = true
var _cooldown: float = 0.0
var fireRate: float = 0.1
var force: float = 110
var moving: bool = true
@onready var muzzle: Marker2D = $Marker2D
@onready var timer: Timer = $Timer
@export var max_direction_left: float = -180.0
@export var max_direction_right: float = 0.0

func _ready() -> void:
	max_direction_left += 15
	if max_direction_right > 0.0:
		max_direction_right -= 15



func _process(delta: float) -> void:
	if not _canShoot:
		_cooldown -= delta
		if _cooldown <= 0.0:
			_canShoot = true
			
	if vehicle_base.driving:
		if moving:
			if Input.is_action_pressed("left"):
				moving = false
				timer.start()
				if rotation_degrees > max_direction_left:
					rotation_degrees -= 15
			elif Input.is_action_pressed("right"):
				moving = false
				timer.start()
				if rotation_degrees < max_direction_right:
					rotation_degrees += 15
		if Input.is_action_pressed("shoot"):
			shoot()

func shoot() -> bool:
	if not _canShoot:
		print("no se puede")
		return false
	
	_canShoot = false
	_cooldown = fireRate
	
	var instance = bullet.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = muzzle.global_position
	instance.rotation = rotation
	return true


func _on_timer_timeout() -> void:
	moving = true
