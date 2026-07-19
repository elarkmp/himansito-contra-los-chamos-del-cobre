extends Control
@onready var texto_medio: Label = $"CanvasLayer/texto medio"
@onready var texto_bajo: Label = $"CanvasLayer/texto bajo"
var tween

func text_center(texto: String, tween_duration: float = 0.5, duration: float = 3, color: Color = Color.WHITE):
	texto_medio.modulate = color
	texto_medio.text = texto
	texto_medio.modulate.a = 0.0
	texto_medio.show()
	tween = create_tween()
	tween.tween_property(texto_medio, "modulate:a", 1.0, tween_duration)
	await tween.finished
	await get_tree().create_timer(duration).timeout
	tween = create_tween()
	tween.tween_property(texto_medio, "modulate:a", 0.0, tween_duration)
	await tween.finished
	texto_medio.hide()

func text_down(texto: String, tween_duration: float = 0.5, duration: float = 3, color: Color = Color.WHITE):
	texto_bajo.modulate = color
	texto_bajo.text = texto
	texto_bajo.modulate.a = 0.0
	texto_bajo.show()
	tween = create_tween()
	tween.tween_property(texto_bajo, "modulate:a", 1.0, tween_duration)
	await tween.finished
	await get_tree().create_timer(duration).timeout
	tween = create_tween()
	tween.tween_property(texto_bajo, "modulate:a", 0.0, tween_duration)
	await tween.finished
	texto_bajo.hide()
