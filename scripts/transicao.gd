extends CanvasLayer

# Esse node deve ser a RAIZ de uma cena própria (Transicao.tscn), registrada como Autoload.
# Assim ele existe o tempo todo, por cima de qualquer cena, e não precisa recriar o fade em cada uma.

@onready var fade: ColorRect = $Fade

func _ready() -> void:
	layer = 100   # garante que fica por cima de tudo
	fade.color.a = 0.0
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE   # não bloqueia cliques quando transparente

func trocar_cena(caminho: String, duracao: float = 0.5) -> void:
	fade.mouse_filter = Control.MOUSE_FILTER_STOP   # bloqueia cliques durante a transição

	var tween_saida: Tween = create_tween()
	tween_saida.tween_property(fade, "color:a", 1.0, duracao)
	await tween_saida.finished

	get_tree().change_scene_to_file(caminho)
	await get_tree().process_frame   # espera a cena nova terminar de carregar

	var tween_entrada: Tween = create_tween()
	tween_entrada.tween_property(fade, "color:a", 0.0, duracao)
	await tween_entrada.finished

	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
