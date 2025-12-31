@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@onready var mesh = $"../MeshInstance3D"
@onready var anim = $"../AnimationPlayer"

var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer
var album = false
var done = false
var is_mesh = true
var inter = false

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	mesh.visible = false
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))
	Room1GameEvents.connect("album_taken", Callable(self, '_on_album_taken'))

func _on_album_taken():
	album = true

func _on_pointer_event(event):	
	if done or !inter:
		return

	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			mesh.visible = true
		XRToolsPointerEvent.Type.EXITED:
			mesh.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			mesh.queue_free()
			is_mesh = false
			
			anim.play("Photo")
			var photo = get_parent().get_node("Photo")
			photo.enabled = true
			
			done = true
