@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@export var original_position: Vector3 = Vector3(-0.1, 0.25, 0)


@onready var mesh = $"../MeshInstance3D"
@onready var viewport = $"../Viewport2Din3D"

var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer
var hidden_position: Vector3 = Vector3(0, -15, 0)

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	mesh.visible = false
	viewport.transform.origin = hidden_position
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))
	Room1GameEvents.connect("close_exit", Callable(self, "_on_close_exit"))

func _on_close_exit():
	viewport.transform.origin = hidden_position
	left_pointer.visible = false
	right_pointer.visible = false
	
	var move = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/MovementDirect")
	move.enabled = true
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_pointer_event(event):
	var player = get_tree().get_current_scene().get_node("Player/XROrigin3D/PlayerBody")
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	if distance >= 2.0:
		mesh.visible = false
		return
	
	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			mesh.visible = true
		XRToolsPointerEvent.Type.EXITED:
			mesh.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			mesh.visible = false
			viewport.transform.origin = original_position
			left_pointer.visible = true
			right_pointer.visible = true
			
			var move = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/MovementDirect")
			move.enabled = false
			
			disconnect("pointer_event", Callable(self, "_on_pointer_event"))
