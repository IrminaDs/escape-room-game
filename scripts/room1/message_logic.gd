extends Node

@onready var message = get_parent()

var original_transform: Transform3D

func _ready():
	original_transform = message.global_transform
		
	if message.has_signal("released"):
		message.connect("released", Callable(self, "_on_released"))

func _on_released(pickable, by):
	if pickable == message:
		message.set_deferred("global_transform", original_transform)
