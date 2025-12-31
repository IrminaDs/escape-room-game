extends Node

@export var info_pivot: Node3D

func _ready():
	if info_pivot:
		info_pivot.visible = false
	var parent_object = get_parent()
	
	if parent_object.has_signal("picked_up"):
		parent_object.connect("picked_up", _on_picked_up)
	
	if parent_object.has_signal("dropped"):
		parent_object.connect("dropped", _on_dropped)

func _on_picked_up(_picker = null):
	if info_pivot:
		info_pivot.visible = true

func _on_dropped(_picker = null):
	if info_pivot:
		info_pivot.visible = false
