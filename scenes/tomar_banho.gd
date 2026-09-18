extends Node2D

@export var raio_deteccao: float = 80.0
@export var progresso_necessario: float = 300.0

@onready var sabao: Node2D = $Sabao
@onready var manchas_container: Node2D = $Manchas
@onready var botao_verificar: Button = $BotaoVerificar

var manchas: Array = []
var liberado: bool = false
var arrastando: bool = false
var terminou: bool = false

func _ready() -> void:
	for filho in manchas_container.get_children():
		manchas.append({"node": filho, "progresso": 0.0, "limpa": false})

func _on_botao_verificar_pressed() -> void:
	if GameState.pode_fazer("tomar_banho"):
		liberado = true
		botao_verificar.visible = false
	else:
		print("Ainda não dá pra tomar banho hoje!")
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

func _input(event: InputEvent) -> void:
	if not liberado or terminou:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and sabao.global_position.distance_to(event.position) < 60.0:
			arrastando = true
			%Som.play()
		elif not event.pressed:
			arrastando = false

	if event is InputEventMouseMotion and arrastando:
		sabao.global_position = event.position
		

		for mancha in manchas:
			if mancha["limpa"]:
				continue

			if sabao.global_position.distance_to(mancha["node"].global_position) < raio_deteccao:
				mancha["progresso"] += event.relative.length()
				var p: float = clamp(mancha["progresso"] / progresso_necessario, 0.0, 1.0)
				mancha["node"].modulate.a = 1.0 - p

				if p >= 1.0:
					mancha["limpa"] = true
					mancha["node"].visible = false

		_verificar_fim()

func _verificar_fim() -> void:
	for mancha in manchas:
		if not mancha["limpa"]:
			return

	terminou = true
	print("Banho concluído!")
	var avancou_dia: bool = GameState.completar("tomar_banho")
	if avancou_dia and GameState.jogo_terminou():
		Transicao.trocar_cena_com_final("res://scenes/main_menu.tscn")
	elif avancou_dia:
		Transicao.trocar_cena_com_passagem_de_dia("res://scenes/Banheiro.tscn")
	else:
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")
