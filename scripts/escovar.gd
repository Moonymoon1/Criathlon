extends Node2D

@export var distancia_minima: float = 40.0
@export var movimentos_para_ganhar: int = 10
@export var limite_horizontal: float = 100.0   # quanto a escova pode se afastar do centro pra cada lado

@onready var escova: Node2D = $Escova

var arrastando: bool = false
var centro_x: float = 0.0
var deslocamento: float = 0.0     # quanto a escova já andou a partir do centro
var acumulado_desde_troca: float = 0.0
var direcao_anterior: int = 0
var contador: int = 0
var terminou: bool = false

func _ready() -> void:
	escova.visible = false   # a escova começa escondida

func _input(event: InputEvent) -> void:
	if terminou:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and escova.global_position.distance_to(event.position) < 60.0:
			arrastando = true
			escova.visible = true   # mostra a escova assim que clica na boca
			centro_x = escova.global_position.x
			deslocamento = 0.0
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # esconde e trava o cursor
		elif not event.pressed and arrastando:
			arrastando = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)   # devolve o cursor normal

	if event is InputEventMouseMotion and arrastando:
		# event.relative = quanto o mouse se moveu desde o último frame
		deslocamento = clamp(deslocamento + event.relative.x, -limite_horizontal, limite_horizontal)
		escova.global_position.x = centro_x + deslocamento

		acumulado_desde_troca += event.relative.x
		if abs(acumulado_desde_troca) >= distancia_minima:
			var direcao_atual: int = 1 if acumulado_desde_troca > 0 else -1
			if direcao_atual != direcao_anterior and direcao_anterior != 0:
				contador += 1
				print("Movimentos: ", contador, "/", movimentos_para_ganhar)
				if contador >= movimentos_para_ganhar:
					terminou = true
					escova.visible = false   # esconde a escova ao terminar
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					print("Dente escovado!")
			direcao_anterior = direcao_atual
			acumulado_desde_troca = 0.0
