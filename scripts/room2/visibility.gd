extends Node

func _ready():
	Room2GameEvents.connect("computer_unlocked", Callable(self, "_on_comp_unlocked"))

func _on_comp_unlocked():
	self.visbility=true
