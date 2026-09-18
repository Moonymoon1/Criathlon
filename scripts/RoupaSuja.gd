extends Area2D

@onready var roupaSuja: Sprite2D = $Roupa
@export var terminou := false
@export var liberado := true
static var progresso := 0
const TOTAL := 5

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if not liberado or terminou:
		return
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Roupa.visible = false
		terminou = true
		progresso += 1
		
		if progresso >= TOTAL:
			print("Prontinho, tudo no seu lugar!")
			Transicao.trocar_cena("res://scenes/Banheiro.tscn")
