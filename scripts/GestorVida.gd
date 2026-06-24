extends Node

@export var vida = 10;
@export var muerto = false;

func DamageEntity(damage: int):
	vida -= damage;
	
	if (vida <= 0):  
		muerto = true;
		print("Morido Fokin Asi muelto");
		
	pass
