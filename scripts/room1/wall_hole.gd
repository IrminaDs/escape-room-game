extends CSGBox3D


func _ready() -> void:
	self.visible = false
	
	Room1GameEvents.connect("clock_lock", Callable(self, "_on_clock_lock"))

func _on_clock_lock():
	self.visible = true
