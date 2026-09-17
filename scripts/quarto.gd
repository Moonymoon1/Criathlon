extends Node2D

func _on_area_banheiro_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if GameState.pronto_para_dormir:
			print("Vai dormir na cama")
			return
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

func _on_area_cama_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not GameState.pronto_para_dormir:
			print("Ainda não fui no banheiro")
			return
		GameState.pronto_para_dormir = false
		Transicao.trocar_cena("res://scenes/Quarto.tscn")
