extends Area2D

@onready var roupaSuja: Sprite2D = $Roupa
@onready var botao_verificar: Button = %BotaoVerificar

@export var terminou := false
static var liberado := false
static var progresso := 0
const TOTAL := 5

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_botao_verificar_pressed() -> void:
	if GameState.pode_fazer("lavar_roupa"):
		liberado = true
		botao_verificar.visible = false
	else:
		print("Ainda não dá pra lavar a roupa hoje!")
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

func _on_input_event(viewport, event, shape_idx):
	if not liberado or terminou:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Roupa.visible = false
		terminou = true
		progresso += 1

		if progresso >= TOTAL:
			print("Prontinho, tudo no seu lugar!")
			var avancou_dia: bool = GameState.completar("lavar_roupa")
			if avancou_dia:
				Transicao.trocar_cena_com_passagem_de_dia("res://scenes/Banheiro.tscn")
			else:
				Transicao.trocar_cena("res://scenes/Banheiro.tscn")
