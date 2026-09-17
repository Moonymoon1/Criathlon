extends Node

@onready var cestoRoupa: Sprite2D = $Cesto
@onready var roupaSuja: Sprite2D = $Roupa

@onready var sprite_barra: Sprite2D = $SpriteBarra

func _ready():
	input_event.connect(_on_input_event)
	
func _on_input_event(viewport, event, shape_idx)
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Roupa.visible = false
