extends Area2D

@export var damage = 1;
 

func _on_body_entered(body: Node2D) -> void:
	
	if body.has_node("GestorVidaComponent"):
		
		var gestorvida = body.get_node("GestorVidaComponent")
		if gestorvida.has_method("DamageEntity"):
			gestorvida.DamageEntity(damage)

	pass 
