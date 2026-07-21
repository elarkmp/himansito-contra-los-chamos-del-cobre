extends Node2D
class_name vehicle
var DRIVING: bool = false
var conductor: CharacterBody2D
@export var speed: float = 450.0
@export var jump_force: float = -850.0
@export var speed_fly: float = -500
@onready var animaciones: AnimatedSprite2D = $animaciones
@onready var state_machine: StateMachine = $"../StateMachine"
@onready var gestor_vida_component: GestorVida = $"../GestorVidaComponent"
var explotion: bool = false

func _ready() -> void:
	gestor_vida_component.On_Entity_Die.connect(_on_gestor_vida_component_on_entity_die)

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

func _on_gestor_vida_component_on_entity_die() -> void:
	if state_machine.current_state.name == "EXPLODE": return
	state_machine._change_to("EXPLODE")
	
