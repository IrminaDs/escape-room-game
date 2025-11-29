@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@onready var sfx_player = $"../SfxPlayer"
@onready var music_player = $"../MusicPlayer"
@onready var mesh = $"../MeshInstance3D"
@onready var anim = $"../Sketchfab_Scene/AnimationPlayer"

var radio_on = false
var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	mesh.visible = false
	
	var stream = load("res://models/Room1/sounds/Canon in D for Two Harps.mp3")
	stream.loop = true
	music_player.stream = stream
	toggle_radio()
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))

func toggle_radio():
	sfx_player.play()

	if not radio_on:
		anim.play("Switch1")
		await sfx_player.finished
		await get_tree().create_timer(1).timeout
		music_player.play()
		radio_on = true
	else:
		anim.play_backwards("Switch1")
		music_player.stop()
		radio_on = false

func _on_pointer_event(event):
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
			toggle_radio()
