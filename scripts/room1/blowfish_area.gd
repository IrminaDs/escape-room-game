@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@onready var mesh = $"MeshInstance3D"
@onready var anim: AnimationPlayer = $"../Fish/AnimationPlayer"
@onready var photo = $"../Photo"
@onready var audio = $"../AudioStreamPlayer3D"

var album = false
var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	mesh.visible = false
	photo.visible = false
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))
	Room1GameEvents.connect("album_taken", Callable(self, '_on_album_taken'))

func _on_album_taken():
	album = true

func _on_pointer_event(event):
	if !album:
		return
	
	var player = get_tree().get_current_scene().get_node("Player/XROrigin3D/PlayerBody")
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	if distance >= 3.0:
		mesh.visible = false
		return
	
	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			mesh.visible = true
		XRToolsPointerEvent.Type.EXITED:
			mesh.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			mesh.visible = false
			
			anim.play("Blow")
			await anim.animation_finished
			audio.play()
			
			photo.enabled = true
			photo.visible = true
			disconnect("pointer_event", Callable(self, "_on_pointer_event"))
