extends Node3D

func _ready():
	if has_node("XRToolsPickable"):
		var pickable = $XRToolsPickable
		pickable.connect("picked_up", Callable(self, "_on_picked_up"))

func _on_picked_up():
	Room2GameEvents.emit_signal("lever_picked_up")
