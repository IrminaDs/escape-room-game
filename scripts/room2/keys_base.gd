extends Node3D

func _ready():
	Room2GameEvents.connect("computer_unlocked", Callable(self, "_on_computer_unlocked"))

func _on_computer_unlocked():
	await get_tree().create_timer(1.0).timeout
	self.visible=true
