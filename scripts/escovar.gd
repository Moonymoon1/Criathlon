extends Node2D

@export var cliques_necessarios: int = 5

@onready var area_esquerda: Area2D = $AreaEsquerda
@onready var area_direita: Area2D = $AreaDireita

var contador_esquerda: int = 0
var contador_direita: int = 0
var lado_atual: String = "esquerda"   
var terminou: bool = false

func _ready() -> void:
	_atualizar_visibilidade()

func _on_area_esquerda_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if terminou or lado_atual != "esquerda":
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		contador_esquerda += 1
		print("Esquerda: ", contador_esquerda, "/", cliques_necessarios)
		_trocar_lado()

func _on_area_direita_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if terminou or lado_atual != "direita":
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		contador_direita += 1
		print("Direita: ", contador_direita, "/", cliques_necessarios)
		_trocar_lado()

func _trocar_lado() -> void:
	if contador_esquerda >= cliques_necessarios and contador_direita >= cliques_necessarios:
		terminou = true
		area_esquerda.visible = false
		area_direita.visible = false
		print("Dente escovado!")
		GameState.completar("escovar_dente")
		get_tree().change_scene_to_file("res://scenes/Banheiro.tscn")
		return

	if lado_atual == "esquerda" and contador_direita < cliques_necessarios:
		lado_atual = "direita"
	elif lado_atual == "direita" and contador_esquerda < cliques_necessarios:
		lado_atual = "esquerda"

	_atualizar_visibilidade()

func _atualizar_visibilidade() -> void:
	area_esquerda.visible = (lado_atual == "esquerda")
	area_direita.visible = (lado_atual == "direita")
