extends Area2D



var is_interactable
var task_done = false
var have_energy
var failed_task_txt:String
var succeded_task_txt:String
var already_done_task_txt:String

func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	_show_text()


func _show_text():
	if (Input.is_action_just_pressed("mouse1") 
	and is_interactable == true 
	and task_done == false
	and have_energy == false):
		if failed_task_txt == null:
			print("não consigui :(")
		else:
			print(failed_task_txt)

func _on_mouse_entered() -> void:
	is_interactable = true
	


func _on_mouse_exited() -> void:
	is_interactable = false
