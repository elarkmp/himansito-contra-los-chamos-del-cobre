extends Node2D
class_name vehicle
var DRIVING: bool = false
var conductor: CharacterBody2D
@export var speed: float = 450.0
@export var jump_force: float = -850.0
@export var speed_fly: float = -500
@onready var animaciones: AnimatedSprite2D = $animaciones


func _process(_delta: float) -> void:
	if not DRIVING: return
	conductor.global_position = global_position

func enter_vehicle(driver: CharacterBody2D):
	conductor = driver
	DRIVING = true

func exit_vehicle():
	DRIVING = false

func animation(anim_name: String):
	animaciones.play(anim_name)
