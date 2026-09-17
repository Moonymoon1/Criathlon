extends Control

@export var start_menu: VBoxContainer
@export var play_menu: VBoxContainer
@export var options_menu: VBoxContainer

func _ready() -> void:
	start_menu.hide()
	start_menu.process_mode = Node.PROCESS_MODE_DISABLED
	play_menu.hide()
	play_menu.process_mode = Node.PROCESS_MODE_DISABLED
	options_menu.hide()
	options_menu.process_mode = Node.PROCESS_MODE_DISABLED
