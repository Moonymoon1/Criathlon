extends Button

@export var open_menu: VBoxContainer
@export var close_menu: VBoxContainer

@export_file("*.tscn") var change_scene: String

@onready var forward_sfx = preload("res://imports/audio/sfx/SFXmouse-foward(1).wav")
@onready var backward_sfx = preload("res://imports/audio/sfx/SFXmouse-back(1).wav")

@export_group("bools")
@export var unpause: bool
@export var forward: bool

func _on_pressed() -> void:
	if unpause:
		get_tree().paused = false
	
	if forward:
		AudioManager.play_one_shot(forward_sfx, 20)
	else:
		AudioManager.play_one_shot(backward_sfx, 20)
	
	if open_menu != null:
		open_menu.process_mode = Node.PROCESS_MODE_INHERIT
		open_menu.show()
	
	if close_menu != null:
		close_menu.process_mode = Node.PROCESS_MODE_DISABLED
		close_menu.hide()
	
	if change_scene != "":
		get_tree().change_scene_to_file(change_scene)
	else:
		pass
	
