extends Node2D

@onready var dialog_ui = %DialogUI
@onready var interactable = %interactable

var dialog_index

var dialog_lines : Array = []

func _ready() -> void:
	dialog_index = 0

func load_dialog_lines(file_path):
	dialog_lines = load_dialog(file_path)
	_process_current_line()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if dialog_lines == []:
		pass

func _input(event):
	if event.is_action_pressed("mouse1"):
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if dialog_lines != []:
				if dialog_index < len(dialog_lines) - 1:
					dialog_index += 1
					_process_current_line()
				elif dialog_index == len(dialog_lines) -1:
					dialog_ui.hide()
					dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED

func _process_current_line():
	var line = dialog_lines[dialog_index]
	dialog_ui.change_line(line)

func load_dialog(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	var content = file.get_as_text()
	
	var json_content = JSON.parse_string(content)
	
	return json_content
