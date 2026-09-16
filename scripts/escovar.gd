extends Node2D

@export var cliques_necessarios: int = 3   

@export var frames_barra: Array[Texture2D] = []

@onready var sprite_barra: Sprite2D = $SpriteBarra

var contador_esquerdo: int = 0
var contador_direito: int = 0
var esperando: int = MOUSE_BUTTON_LEFT
var aguardando_confirmacao: bool = false   
var terminou: bool = false

func _ready() -> void:
	_atualizar_sprite()

func _input(event: InputEvent) -> void:
	if terminou:
		return

	if aguardando_confirmacao:
		if event is InputEventMouseButton and event.pressed:
			terminou = true
			print("Dente escovado!")
			GameState.completar("escovar_dente")
			get_tree().change_scene_to_file("res://scenes/Banheiro.tscn")
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == esperando:
		if esperando == MOUSE_BUTTON_LEFT:
			contador_esquerdo += 1
			esperando = MOUSE_BUTTON_RIGHT
		else:
			contador_direito += 1
			esperando = MOUSE_BUTTON_LEFT

		_atualizar_sprite()

		if contador_esquerdo >= cliques_necessarios and contador_direito >= cliques_necessarios:
			aguardando_confirmacao = true  

func _atualizar_sprite() -> void:
	if frames_barra.is_empty():
		return

	var total_cliques: int = contador_esquerdo + contador_direito
	var indice: int = clamp(total_cliques, 0, frames_barra.size() - 1)
	sprite_barra.texture = frames_barra[indice]
