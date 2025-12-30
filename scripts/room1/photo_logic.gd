extends Node


@export var sig_num: int = 2

@onready var parent = get_parent()
@onready var audio: AudioStreamPlayer3D = $"../AudioStreamPlayer3D"

func _ready():
	parent.enabled = false
	
	if parent.has_signal("released"):
		parent.connect("released", Callable(self, "_on_released"))

func _on_released(pickable, by):
	if pickable == get_parent():
		Room1GameEvents.emit_signal("photo_unlocked", sig_num)
		
		audio.get_parent().remove_child(audio)
		get_tree().root.add_child(audio)
		audio.play()
		
		parent.queue_free()
