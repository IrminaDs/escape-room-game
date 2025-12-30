@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@onready var label = $"../Label3D"
@onready var viewport = $"../Viewports"

var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer
var open = false

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	label.visible = false
	viewport.visible = false
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_pointer_event(event):
	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			label.visible = true
		XRToolsPointerEvent.Type.EXITED:
			label.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			if open:
				viewport.visible = false
				open = false
			else:
				viewport.visible = true
				open = true
