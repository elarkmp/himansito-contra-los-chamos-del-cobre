class_name GunBase
extends Node2D

@export var weaponres : weapon_res


var fireRate: float = 0.15
var force: float = 110

@onready var sprite: Sprite2D = $Sprite2D
@onready var muzzle: Marker2D = $muzzle

## bala de prueba
var bullet = preload("res://Escenas/Entidades/bullet.tscn")

var _canShoot: bool = true
var _cooldown: float = 0.0

## direcciones
enum directionGun { right, left, up, down }
var direction: directionGun = directionGun.right

func _ready() -> void:
	sprite.texture = weaponres.textura
	fireRate = weaponres.fireRate
	force = weaponres.force
	muzzle.position = weaponres.muzzle_offset

func _process(delta: float) -> void:
	if not _canShoot:
		_cooldown -= delta
		if _cooldown <= 0.0:
			_canShoot = true

## esto se supone que convierte el enum a vector para el proyectil
func convertDirection(_direction: directionGun) -> Vector2:
	var vector: Vector2
	match _direction:
		## derecha
		directionGun.right: 
			vector = Vector2(1, 0)
			#print(str(vector))
		## izquierda
		directionGun.left:
			vector = Vector2(-1, 0)
			#print(str(vector))
		## arriba
		directionGun.up:
			vector = Vector2(0, -1)
			#print(str(vector))
		## abajo
		directionGun.down:
			vector = Vector2(0, 1)
			#print(str(vector))
		## default
		_: 
			vector = Vector2(0, 0)
	return vector

## getter de direccion
func getDirection() -> directionGun:
	return direction

## disparo
func shoot() -> bool:
	if not _canShoot:
		#print("no se puede")
		return false
	
	_canShoot = false
	_cooldown = fireRate
	
	var _direction: Vector2 = convertDirection(getDirection())
	
	var instance = bullet.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = muzzle.global_position
	instance.rotation = rotation
	instance.ImpulsarObjeto(force, _direction)
	
	return true
