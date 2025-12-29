extends DirectionalLight3D

func _ready():
	Room2GameEvents.connect("lever_picked_up", Callable(self, "_on_lever_up"))

func _on_lever_up():
	self.light_color=Color(0.0, 1.0, 0.483, 1.0)
	self.light_energy=4.376
