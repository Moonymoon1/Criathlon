extends Node2D

@export var distancia_total_necessaria: float = 3000.0   # soma de pixels que precisa esfregar até terminar
@export var area_corpo: Rect2 = Rect2(-150, -200, 600, 800)  # retângulo (x, y, largura, altura) relativo ao ponto onde clicou

@onready var sabonete: Node2D = $Sabonete

var arrastando: bool = false
var centro: Vector2 = Vector2.ZERO       # posição onde o sabonete estava quando você clicou
var posicao_relativa: Vector2 = Vector2.ZERO  # o quanto já andou a partir do centro
var distancia_percorrida: float = 0.0
var terminou: bool = false

func _input(event: InputEvent) -> void:
	if terminou:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and sabonete.global_position.distance_to(event.position) < 60.0:
			arrastando = true
			centro = sabonete.global_position
			posicao_relativa = Vector2.ZERO
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif not event.pressed and arrastando:
			arrastando = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion and arrastando:
		posicao_relativa += event.relative

		posicao_relativa.x = clamp(posicao_relativa.x, area_corpo.position.x, area_corpo.position.x + area_corpo.size.x)
		posicao_relativa.y = clamp(posicao_relativa.y, area_corpo.position.y, area_corpo.position.y + area_corpo.size.y)

		sabonete.global_position = centro + posicao_relativa

		distancia_percorrida += event.relative.length()
		if distancia_percorrida >= distancia_total_necessaria:
			terminou = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			print("Banho concluído!")
			GameState.completar("tomar_banho")
			get_tree().change_scene_to_file("res://scenes/Banheiro.tscn")
