extends Area2D

@export var damageTipe: GestorVida.TipoEntidad = GestorVida.TipoEntidad.objeto
@export var damage = 1;

func _on_body_entered(body: Node2D) -> void:
	
	print("Cuerpo Detectado")
	
	if body.has_node("GestorVidaComponent"):
		
		var gestorvida = body.get_node("GestorVidaComponent")
		if gestorvida.has_method("DamageEntity"):
			gestorvida.DamageEntity(damage, damageTipe)

	pass 
