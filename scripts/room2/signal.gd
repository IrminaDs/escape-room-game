extends Node

@onready var parent_pickable = get_parent()

func _ready():
	if parent_pickable.has_signal("grabbed"):
		parent_pickable.connect("grabbed", Callable(self, "_on_grabbed"))

func _on_grabbed(pickable, by):
	if pickable == get_parent():
		Room2GameEvents.emit_signal("lever_picked_up")
