extends Node3D

@onready var lock_area: Node3D = $Lock

func _ready():
	Room2GameEvents.connect("computer_unlocked", Callable(self, "_on_computer_unlocked"))

func _on_computer_unlocked():
	if lock_area:
		lock_area.queue_free()
	
