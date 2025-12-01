extends Node


@export var sig_num: int = 1

@onready var parent = get_parent()

func _ready():
	parent.enabled = false
	
	if parent.has_signal("released"):
		parent.connect("released", Callable(self, "_on_released"))

func _on_released(pickable, by):
	if pickable == get_parent():
		Room1GameEvents.emit_signal("photo_unlocked", sig_num)
		parent.queue_free()
