class_name GunBase
extends Node2D

@export var textura: Texture2D
@export var fireRate: float = 0.15

@onready var sprite: Sprite2D = $Sprite2D

var _canShoot: bool = true
var _cooldown: float = 0.0

## direcciones
enum directionGun { right, left }
var direction: directionGun = directionGun.right

func _ready() -> void:
	sprite.texture = textura

func _process(delta: float) -> void:
	if not _canShoot:
		_cooldown -= delta
		if _cooldown <= 0.0:
			_canShoot = true

## disparo
func shoot() -> bool:
	if not _canShoot:
		print("no se puede")
		return false
	_canShoot = false
	_cooldown = fireRate
	print("disparo en direccion " + str(direction))
	return true
