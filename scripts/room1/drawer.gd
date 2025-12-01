@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@export var anim_name: String = "Open_drawer"

@onready var high = $Highlight
@onready var anim: AnimationPlayer = self.get_owner().get_node("StaticBody3D/Sketchfab_Scene/AnimationPlayer")

var can_open = false
var is_open = false
var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	high.visible = false
	
	Room1GameEvents.connect("album_taken", Callable(self, "_on_album_taken"))
	connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_album_taken():
	can_open = true

func _on_pointer_event(event):
	print(event)
	if !can_open:
		return
	
	var player = get_tree().get_current_scene().get_node("Player/XROrigin3D/PlayerBody")
	var distance = global_transform.origin.distance_to(player.global_transform.origin)
	if distance >= 2.0:
		high.visible = false
		return
	print("hi")
	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			high.visible = true
		XRToolsPointerEvent.Type.EXITED:
			high.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			high.visible = false
			if !is_open:
				anim.play(anim_name)
				is_open = !is_open
				await anim.animation_finished
				
				var photo = get_parent().get_node("Photo")
				if photo != null:
					photo.enabled = true
			else:
				anim.play_backwards(anim_name)
				is_open = !is_open
				await anim.animation_finished
			high.visible = true
