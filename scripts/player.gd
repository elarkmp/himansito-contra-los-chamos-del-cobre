class_name Player
extends CharacterBody2D
@onready var animaciones: AnimatedSprite2D = $AnimatedSprite2D
@onready var vida: GestorVida = $GestorVidaComponent
@onready var driving


@export var gravity_scale = 3
@export var speed = 500
@export var jump_force = -1000
@export var coyote_time = 0.15

func animation(anim_name: String):
	animaciones.play(anim_name)

## lógica
func _physics_process(_delta: float) -> void:
	var input_axis = Input.get_axis("left","right")
	if input_axis != 0:
		animaciones.flip_h = input_axis < 0
	#print("vida:" + str(vida.vida))

func _on_gestor_vida_component_on_entity_die() -> void:
	queue_free()

func drive(drive: bool):
	if drive:
		driving = true
	else:
		driving = false
