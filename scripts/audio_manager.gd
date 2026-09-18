extends Node

var music_stream : AudioStreamPlayer

@export_group("Main")
@export var clips : Node
@export var one_shots: Node
@export var audio_one_shot_scene: PackedScene

func play(audio_name: String, from_position: float = 0.0, restart: bool = false) -> void:
	if restart and music_stream and music_stream.name == audio_name:
		return
		
		music_stream = clips.get_node(audio_name)
		music_stream.play(from_position)

func play_one_shot(audio_stream: AudioStream, volume_bd: float = 0.0, from_position: float = 0.0) -> AudioOneShot:
	var audio_one_shot: AudioOneShot = audio_one_shot_scene.instantiate()
	audio_one_shot.stream = audio_stream
	audio_one_shot.volume_db = volume_bd
	audio_one_shot.from_position = from_position
	
	one_shots.add_child(audio_one_shot)
	return audio_one_shot
