extends Button

@export var open_menu: VBoxContainer
@export var close_menu: VBoxContainer
@export var unpause: bool
@export_file("*.tscn") var change_scene: String

func _on_pressed() -> void:
	if open_menu != null:
		open_menu.process_mode = Node.PROCESS_MODE_INHERIT
		open_menu.show()
	
	if close_menu != null:
		close_menu.process_mode = Node.PROCESS_MODE_DISABLED
		close_menu.hide()
	
	#if unpause:
		#get_tree().paused = false
	
	if change_scene != "":
		get_tree().change_scene_to_file(change_scene)
	else:
		pass
	
