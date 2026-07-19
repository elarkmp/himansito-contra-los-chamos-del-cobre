extends Camera2D

@export var target: Node2D
var _max_x: float = 0.0
var _initial_y: float = 300

## si el target se destruye la camara se setea al nuevo player, y el jugador en teoria deberia
## salir en la posicion de la camara asi es pero como no c que lo haga halberd
func _process(_delta):
	if not target: 
		for n in get_tree().current_scene.get_children():
			if n is Player:
				target = n
				break
	if target.global_position.x > _max_x:
		_max_x = target.global_position.x
	global_position.x = _max_x
	global_position.y = _initial_y
	pass
