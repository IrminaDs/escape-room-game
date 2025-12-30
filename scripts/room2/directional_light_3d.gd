extends DirectionalLight3D

func _ready():
	Room2GameEvents.connect("lever_picked_up", Callable(self, "_on_lever_up"))
	Room2GameEvents.connect("computer_unlocked", Callable(self, "_on_computer_unlocked"))

func _on_lever_up():
	self.light_color=Color(0.0, 1.0, 0.483, 1.0)
	self.light_energy=4.376

func _on_computer_unlocked():
	self.light_color=Color.WHITE_SMOKE
	self.light_energy=1.654
