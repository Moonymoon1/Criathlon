extends Area2D

var is_interactable
var task_done = false
@export var have_energy:bool
@export var failed_task_txt:String
@export var succeded_task_txt:String
@export var already_done_task_txt:String

@onready var dialog_ui = %DialogUI
@onready var main_scene = $".."

@onready var nao_consigo_txt = "res://dialog/nao_consigo.json"
@onready var sim_consigo_txt = "res://dialog/sim_consigo.json"
@onready var ja_fiz_txt = "res://dialog/ja_fiz_isso.json"

func _ready() -> void:
	pass 

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	print(is_interactable)
	_show_text()
	if Input.is_action_just_pressed("ui_accept"):
		task_done = true

func _show_text():
	
	# não consigo fazer task agora
	if (Input.is_action_just_pressed("mouse1") 
	and is_interactable == true 
	and task_done == false
	and have_energy == false):
		if failed_task_txt == null:
			print("vc não adionou texto")
		else:
			start_dialog_ui(nao_consigo_txt)
	elif (Input.is_action_just_pressed("mouse1")
	and is_interactable == true
	and task_done == false
	and have_energy == true):
		if succeded_task_txt == null:
			print("vc não adicionou texto")
		else:
			start_dialog_ui(sim_consigo_txt)
	elif (Input.is_action_just_pressed("mouse1")
	and is_interactable == true
	and task_done == true):
		if already_done_task_txt == null:
			print("vc não adionou texto")
		else:
			start_dialog_ui(ja_fiz_txt)

func start_dialog_ui(txt):
	main_scene.dialog_index = 0
	main_scene.load_dialog_lines(txt)
	dialog_ui.process_mode = Node.PROCESS_MODE_INHERIT
	dialog_ui.visible = true
	dialog_ui.dialog.visible_ratio = 0
	dialog_ui.animate_text = true
	dialog_ui.text_blip_timer.start()
	
	is_interactable = false

func _on_mouse_entered() -> void:
	#if dialog_ui.visible == false:
	is_interactable = true
	

func _on_mouse_exited() -> void:
	#if dialog_ui.visible == false:
	is_interactable = false
