extends AudioStreamPlayer
class_name AudioOneShot

var from_position: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished.connect(self.queue_free)
	play(from_position)
