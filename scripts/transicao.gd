extends CanvasLayer

@onready var fade: ColorRect = $Fade
@onready var video: VideoStreamPlayer = $Video

var videos_dia: Dictionary = {
	1: preload("res://videos/passagem_dia2.ogv"),
	2: preload("res://videos/passagem_dia3.ogv"),
	3: preload("res://videos/passagem_dia4.ogv"),
	4: preload("res://videos/passagem_dia1.ogv"),
}

#var video_final: VideoStream = preload("res://videos/final.ogv")

func _ready() -> void:
	layer = 100
	fade.color.a = 0.0
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	video.visible = false

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

func trocar_cena_com_passagem_de_dia(caminho: String, duracao_fade: float = 0.5) -> void:
	fade.mouse_filter = Control.MOUSE_FILTER_STOP

	var tween_saida: Tween = create_tween()
	tween_saida.tween_property(fade, "color:a", 1.0, duracao_fade)
	await tween_saida.finished

	var dia_que_terminou: int = GameState.dia_atual - 1
	if videos_dia.has(dia_que_terminou):
		video.stream = videos_dia[dia_que_terminou]
		video.visible = true
		video.play()
		await video.finished
		video.stop()
		video.visible = false

	get_tree().change_scene_to_file(caminho)
	await get_tree().process_frame

	var tween_entrada: Tween = create_tween()
	tween_entrada.tween_property(fade, "color:a", 0.0, duracao_fade)
	await tween_entrada.finished

	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE

func trocar_cena_com_final(caminho: String, duracao_fade: float = 0.5) -> void:
	fade.mouse_filter = Control.MOUSE_FILTER_STOP

	var tween_saida: Tween = create_tween()
	tween_saida.tween_property(fade, "color:a", 1.0, duracao_fade)
	await tween_saida.finished

	var dia_que_terminou: int = GameState.dia_atual - 1
	if videos_dia.has(dia_que_terminou):
		video.stream = videos_dia[dia_que_terminou]
		video.visible = true
		video.play()
		await video.finished
		video.stop()

	#video.stream = video_final
	video.visible = true
	video.play()
	await video.finished
	video.stop()
	video.visible = false

	get_tree().change_scene_to_file(caminho)
	await get_tree().process_frame

	var tween_entrada: Tween = create_tween()
	tween_entrada.tween_property(fade, "color:a", 0.0, duracao_fade)
	await tween_entrada.finished

	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
