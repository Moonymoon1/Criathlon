extends Node2D

func _on_area_banheiro_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

func _on_area_cama_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameState.pronto_para_dormir = false   # já vai dormir, reseta a flag
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")
