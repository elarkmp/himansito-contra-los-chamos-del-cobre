extends Node2D

## este script debe crea un jugador mientras no exista otro 
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	findAndCreatePlayerInstances()
	pass

func findAndCreatePlayerInstances() -> void:
	var exists = false
	for n in get_tree().current_scene.get_children():
		if n is Player:
			exists = true
			break
	if !exists:
		var manager = preload("res://Escenas/Entidades/player.tscn").instantiate()
		get_tree().current_scene.add_child(manager)
	pass
