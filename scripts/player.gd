class_name Player
extends CharacterBody2D
@onready var animaciones: AnimatedSprite2D = $AnimatedSprite2D
@onready var vida: GestorVida = $GestorVidaComponent
@onready var state_machine: StateMachine = $StateMachine

var driving: bool = false
var can_move: bool = true
@export var gravity_scale = 3
@export var speed = 500
@export var jump_force = -1000
@export var coyote_time = 0.15

func animation(anim_name: String):
	animaciones.play(anim_name)

## lógica
func _physics_process(_delta: float) -> void:
	if not can_move: return
	var input_axis = Input.get_axis("left","right")
	if input_axis != 0:
		animaciones.flip_h = input_axis < 0
	#print("vida:" + str(vida.vida))

func _on_gestor_vida_component_on_entity_die() -> void:
	if state_machine.current_state.name == "DEATH":
		return

	state_machine._change_to("DEATH")
	can_move = false

func drive(is_drive: bool):
	if is_drive:
		driving = true
		can_move = false
	else:
		driving = false
		can_move = true
