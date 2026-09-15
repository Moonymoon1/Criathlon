extends Node2D

@export var cliques_necessarios: int = 5   
var contador_esquerda: int = 0
var contador_direita: int = 0
var terminou: bool = false

func _on_area_esquerda_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if terminou:
		return
		
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		contador_esquerda += 1
		print("Esquerda: ", contador_esquerda, "/", cliques_necessarios)
		_verificar_fim()

func _on_area_direita_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if terminou:
		return
	
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		contador_direita += 1
		print("Direita: ", contador_direita, "/", cliques_necessarios)
		_verificar_fim()

func _verificar_fim() -> void:
	if contador_esquerda >= cliques_necessarios and contador_direita >= cliques_necessarios:
		terminou = true
		print("Dente escovado!")
