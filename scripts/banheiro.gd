extends Node2D

func _ready() -> void:
	$Som.play()
	
func _on_area_escovar_dentes_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Transicao.trocar_cena("res://scenes/EscovarDente.tscn")

func _on_area_tomar_banho_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Transicao.trocar_cena("res://scenes/TomarBanho.tscn")

func _on_area_lavar_rosto_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Transicao.trocar_cena("res://scenes/LavarRosto.tscn")

func _on_area_lavar_roupa_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Transicao.trocar_cena("res://scenes/JogarRoupaCesto.tscn")
