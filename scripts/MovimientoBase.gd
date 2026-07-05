extends CharacterBody2D

@export var moverse: bool = true;

@export var velocidad: float 
@export var tiempoCambioDireccion: float
@export var probabilidadCambio: float
@export var tiempoMinimoEnCambio: float
@export var tiempoMaximoEnCambio: float
 
@export var objetivo: Node2D
@export var siguiendoObjetivo: bool = true

var nuevaDireccion: Vector2

var reloj = 0

func _ready() -> void:
	
	$GestorVidaComponent.On_Entity_Die.connect(On_Entity_Die)
	
	pass

func On_Entity_Die() -> void:
	
	moverse = false
	
	pass

func _process(delta: float) -> void:
	
	if(moverse == false): return
	
	DecidirCambioDireccion(delta)
	
	pass

func DecidirCambioDireccion(delta: float):
	
	reloj += 1 * delta;
	
	if(reloj < tiempoCambioDireccion):
		return
	
	reloj = 0
	
	var chance = randi_range(0, 100)
	
	if(chance <= probabilidadCambio):
		NuevaDireccion()
		siguiendoObjetivo = !siguiendoObjetivo
		print("Moviendose a ", nuevaDireccion)
	
	pass

func NuevaDireccion():
	
	var nuevoVector: Vector2
	nuevaDireccion = nuevoVector
	
	nuevaDireccion.x = randi_range(-1, 1)
	pass

func _physics_process(delta: float) -> void:
	if(moverse == false): return
	
	AplicarGravedad(delta)
	
	if(siguiendoObjetivo):
		MoverPersonaje(delta, ObtenerHubicacion())
	else:
		if(nuevaDireccion.x == 0):
			return
		MoverPersonaje(delta, nuevaDireccion)
	
	move_and_slide()
	pass

func ObtenerHubicacion() -> Vector2:  
	if objetivo == null: return Vector2(0, 0)
	var vectorObjetivo = objetivo.global_position - global_position;
	vectorObjetivo.normalized()
	
	return vectorObjetivo

func MoverPersonaje(delta: float, direccion: Vector2):
	
	velocity.x += direccion.x * velocidad * delta;
	
	pass

func AplicarGravedad(delta: float):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	pass
