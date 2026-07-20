extends StateBase
@onready var player: Player = $"../.."

func _start():
	controlled_node.hide()

func on_process(_delta):
	if not player.driving:
		state_machine._change_to("IDLE")
		controlled_node.show()
	controlled_node.move_and_slide()
