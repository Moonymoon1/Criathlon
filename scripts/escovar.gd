extends Node2D

@export var movimentos_necessarios: int = 14
@export var distancia_minima: float = 40.0

@onready var escova: Node2D = $Escova
@onready var espuma: Sprite2D = $Espuma
@onready var botao_verificar: Button = $BotaoVerificar

var liberado: bool = false
var arrastando: bool = false
var terminou: bool = false
var posicao_inicial_x: float = 0.0
var ultima_direcao: int = 0
var contador: int = 0

func _ready() -> void:
	espuma.modulate.a = 0.0

func _on_botao_verificar_pressed() -> void:
	if GameState.pode_fazer("escovar_dente"):
		liberado = true
		botao_verificar.visible = false
	else:
		print("Ainda não dá pra escovar o dente hoje!")
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

func _input(event: InputEvent) -> void:
	if not liberado or terminou:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and escova.global_position.distance_to(event.position) < 60.0:
			arrastando = true
			posicao_inicial_x = event.position.x
		elif not event.pressed:
			arrastando = false

	if event is InputEventMouseMotion and arrastando:
		escova.global_position.x = event.position.x

		var diferenca: float = event.position.x - posicao_inicial_x
		if abs(diferenca) >= distancia_minima:
			var direcao_atual: int = 1 if diferenca > 0 else -1
			if direcao_atual != ultima_direcao and ultima_direcao != 0:
				contador += 1
				espuma.modulate.a = float(contador) / movimentos_necessarios

				if contador >= movimentos_necessarios:
					terminou = true
					print("Dente escovado!")
					GameState.completar("escovar_dente")
					Transicao.trocar_cena("res://scenes/Banheiro.tscn")

			ultima_direcao = direcao_atual
			posicao_inicial_x = event.position.x
