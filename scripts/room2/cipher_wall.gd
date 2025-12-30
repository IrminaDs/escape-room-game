extends Node3D

func _ready():
	Room2GameEvents.connect("lever_picked_up", Callable(self, "_on_lever_up"))

func _on_lever_up():
	$cipher_yellow.visible=true
	$cipher_green.visible=true
	$cipher_blue.visible=true
	$cipher_red.visible=true
	$label.visible=true
