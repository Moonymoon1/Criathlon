extends Control

@onready var dialog = %dialog
@onready var audio_stream = %audio_stream
@onready var txt_sfx : AudioStream = preload("res://imports/audio/sfx/aa.wav")
@onready var text_blip_timer = %Timer
@onready var dialog_box = %dialog_box
var dialog_box_size: Vector2

const LOW_ANIMATION_SPEED : int = 10
const MID_ANIMATION_SPEED : int = 20
const HIGH_ANIMATION_SPEED : int = 30

const LOW_BLIP_TIMER : float = 0.14
const MID_BLIP_TIMER : float = 0.11
const HIGH_BLIP_TIMER : float = 0.08

var size_update = 10
var vertical_size = 320

var current_animation_speed : int
var animate_text : bool = false
var current_visible_characters : int = 0

func _ready() -> void:
	text_blip_timer.timeout.connect(_on_text_blip_timeout)
	audio_stream.stream = txt_sfx
	current_animation_speed = HIGH_ANIMATION_SPEED
	if current_animation_speed == LOW_ANIMATION_SPEED:
		text_blip_timer.wait_time = LOW_BLIP_TIMER
	elif current_animation_speed == MID_ANIMATION_SPEED:
		text_blip_timer.wait_time = MID_BLIP_TIMER
	elif current_animation_speed == HIGH_ANIMATION_SPEED:
		text_blip_timer.wait_time = HIGH_BLIP_TIMER
	
	
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()

func _process(delta: float) -> void:
	if animate_text:
		if dialog.visible_ratio < 1:
			change_dialog_box_size()
			dialog.visible_ratio += (1.0 / dialog.text.length()) * (current_animation_speed * delta)
			if dialog.visible_characters > current_visible_characters and (dialog.visible_characters & 1) == 0:
				current_visible_characters = dialog.visible_characters
		else:
			animate_text = false
			text_blip_timer.stop()

func change_dialog_box_size():
	dialog_box.custom_minimum_size = Vector2(dialog.text.length() * size_update, vertical_size)

func change_line(line: String):
	current_visible_characters = 0
	dialog.visible_characters = 0
	dialog.text = line
	animate_text = true
	text_blip_timer.start()

func skip_text_animation():
	dialog.visible_ratio = 1

func _on_text_blip_timeout():
	audio_stream.play()
