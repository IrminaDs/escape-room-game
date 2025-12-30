extends Node3D

func _ready():
	if has_node("XRToolsInteractableHandle"):
		var pickable = $InteractableHandle
		pickable.connect("pick_up", Callable(self, "_on_picked_up"))

func _on_picked_up():
	print("grabbed")
	Room2GameEvents.emit_signal("lever_picked_up")
