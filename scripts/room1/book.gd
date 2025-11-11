@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@export var viewport : XRToolsViewport2DIn3D
@export var scene : PackedScene
@onready var highlight = $Highlight
@onready var label: Label3D = $Label3D

var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer


func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	highlight.visible = false
	label.visible = false

	connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_pointer_event(event):
	if viewport == null or scene == null:
		return
		
	if left_pointer.visible == false and right_pointer.visible == false:
		highlight.visible = false
		label.visible = false
		return

	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			highlight.visible = true
			label.visible = true
		XRToolsPointerEvent.Type.EXITED:
			highlight.visible = false
			label.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			if viewport.visible and viewport.scene == scene:
				viewport.visible = false
			else:
				viewport.scene = scene
				viewport.visible = true
				if self.name == "Red":
					Room1GameEvents.emit_signal("book_opened")
