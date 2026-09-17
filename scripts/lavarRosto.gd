extends Node2D

@export var distancia_necessaria: float = 600

@onready var bolinha: Area2D = $AreaLavarRosto
@onready var botao_verificar: Button = $BotaoVerificar

var arrastando: bool = false
var posicao_inicial: Vector2
var terminou: bool = false
var liberado: bool = false

func _on_botao_verificar_pressed() -> void:
	if GameState.pode_fazer("lavar_rosto"):
		liberado = true
		botao_verificar.visible = false
	else:
		print("Ainda não dá pra lavar o rosto hoje!")
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")


func _on_area_lavar_rosto_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not liberado or terminou:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		arrastando = true
		posicao_inicial = bolinha.global_position

func _input(event: InputEvent) -> void:
	if not liberado or terminou or not arrastando:
		return

	if event is InputEventMouseButton and not event.pressed:
		arrastando = false
		bolinha.global_position = posicao_inicial

	if event is InputEventMouseMotion:
		var y_alvo: float = clamp(event.position.y, posicao_inicial.y, posicao_inicial.y + distancia_necessaria)
		bolinha.global_position.y = y_alvo

		if y_alvo >= posicao_inicial.y + distancia_necessaria:
			arrastando = false
			terminou = true
			print("Rosto lavado!")
			GameState.completar("lavar_rosto")
			Transicao.trocar_cena("res://scenes/Banheiro.tscn")
