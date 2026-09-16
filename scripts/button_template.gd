extends Button

@export var open_menu: VBoxContainer
@export var close_menu: VBoxContainer
@export var change_scene: PackedScene

func _on_pressed() -> void:
	if open_menu != null:
		open_menu.process_mode = Node.PROCESS_MODE_INHERIT
		open_menu.show()
	
	if close_menu != null:
		close_menu.process_mode = Node.PROCESS_MODE_DISABLED
		close_menu.hide()
	
	if change_scene != null:
		var new_scene:String = change_scene.resource_path
		get_tree().change_scene_to_file(new_scene)
