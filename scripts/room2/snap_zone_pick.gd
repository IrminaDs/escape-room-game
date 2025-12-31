extends Node

@onready var parent_pickable = get_parent()

func _ready():
	if parent_pickable.has_signal("has_picked_up"):
		parent_pickable.connect("has_picked_up", Callable(self, "_on_has_picked_up"))

func _on_picked_up(pickable, by):
	if pickable == get_parent():
		Room2GameEvents.emit_signal("snapzone_entered")


func _on_snap_zone_has_picked_up(what: Variant) -> void:
	Room2GameEvents.emit_signal("snapzone_entered")
