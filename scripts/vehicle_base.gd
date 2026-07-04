extends CharacterBody2D
class_name vehicle
@export var conductor: CharacterBody2D
var driving: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var camara : Camera2D
