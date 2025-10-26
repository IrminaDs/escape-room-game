extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@export var viewport : XRToolsViewport2DIn3D
@export var scene : PackedScene

@onready var highlight = $Highlight
@onready var left_pointer: XRToolsFunctionPointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
@onready var right_pointer: XRToolsFunctionPointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")

func _ready():
	connect("pointer_event", Callable(self, "_on_pointer_event"))
	highlight.visible = false

func _on_pointer_event(event):
	if viewport == null or scene == null:
		return
		
	if left_pointer.visible == false and right_pointer.visible == false:
		highlight.visible = false
		return

	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			highlight.visible = true
		XRToolsPointerEvent.Type.EXITED:
			highlight.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			if viewport.visible:
				viewport.visible = false
			else:
				viewport.scene = scene
				viewport.visible = true
