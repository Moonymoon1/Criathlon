extends Area2D

@onready var cestoRoupa: Sprite2D = $Cesto
@onready var roupaSuja: Sprite2D = $Roupa

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Roupa.visible = false


func _on_mouse_entered() -> void:
	pass # Replace with function body.
