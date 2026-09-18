extends Node2D

@export var graus_necessarios: float = 1080.0
@export var cor_suja: Color = Color(0.55, 0.45, 0.35, 1.0)

@onready var toalha: Node2D = $Toalha
@onready var rosto: Sprite2D = $Rosto
@onready var botao_verificar: Button = $BotaoVerificar

var liberado: bool = false
var arrastando: bool = false
var terminou: bool = false
var centro: Vector2
var ultimo_angulo: float = 0.0
var angulo_acumulado: float = 0.0

func _ready() -> void:
	centro = rosto.global_position
	rosto.modulate = cor_suja

func _on_botao_verificar_pressed() -> void:
	if GameState.pode_fazer("lavar_rosto"):
		liberado = true
		botao_verificar.visible = false
	else:
		print("Ainda não dá pra lavar o rosto hoje!")
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

func _input(event: InputEvent) -> void:
	if not liberado or terminou:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and toalha.global_position.distance_to(event.position) < 60.0:
			arrastando = true
			ultimo_angulo = (event.position - centro).angle()
			%Som.play()
		elif not event.pressed:
			arrastando = false

	if event is InputEventMouseMotion and arrastando:
		toalha.global_position = event.position

		var angulo_atual: float = (event.position - centro).angle()
		var delta: float = wrapf(angulo_atual - ultimo_angulo, -PI, PI)
		angulo_acumulado += abs(delta)
		ultimo_angulo = angulo_atual

		var progresso: float = clamp(angulo_acumulado / deg_to_rad(graus_necessarios), 0.0, 1.0)
		rosto.modulate = cor_suja.lerp(Color(1, 1, 1, 1), progresso)

		if progresso >= 1.0:
			terminou = true
			print("Rosto lavado!")
			var avancou_dia: bool = GameState.completar("lavar_rosto")
			if avancou_dia and GameState.jogo_terminou():
				Transicao.trocar_cena_com_final("res://scenes/main_menu.tscn")
			elif avancou_dia:
				Transicao.trocar_cena_com_passagem_de_dia("res://scenes/Banheiro.tscn")
			else:
				Transicao.trocar_cena("res://scenes/Banheiro.tscn")
