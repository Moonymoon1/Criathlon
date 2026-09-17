extends CanvasLayer

@onready var fade: ColorRect = $Fade

func _ready() -> void:
	layer = 100
	fade.color.a = 0.0
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE

func trocar_cena(caminho: String, duracao: float = 0.5) -> void:
	fade.mouse_filter = Control.MOUSE_FILTER_STOP

	var tween_saida: Tween = create_tween()
	tween_saida.tween_property(fade, "color:a", 1.0, duracao)
	await tween_saida.finished

	get_tree().change_scene_to_file(caminho)
	await get_tree().process_frame

	var tween_entrada: Tween = create_tween()
	tween_entrada.tween_property(fade, "color:a", 0.0, duracao)
	await tween_entrada.finished

	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
