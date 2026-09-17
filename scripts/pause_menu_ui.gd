extends Control

@onready var pause_menu = %pause_menu

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("escape") 
	and get_tree().paused == false):
		get_tree().paused = true
		
		pause_menu.process_mode = Node.PROCESS_MODE_INHERIT
		pause_menu.show()
	elif (Input.is_action_just_pressed("escape") 
	and get_tree().paused == true
	and pause_menu.visible == true):
		get_tree().paused = false
		pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
		pause_menu.hide()
