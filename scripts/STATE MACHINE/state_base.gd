class_name StateBase
extends Node

##referencia a los nodos que hay que controlar
@onready var controlled_node: Node = self.owner

##referencia a la maquina de estados
var state_machine:StateMachine

#region metodos comunes

func _start():
	pass
	
func _end():
	pass
	
#endregion
