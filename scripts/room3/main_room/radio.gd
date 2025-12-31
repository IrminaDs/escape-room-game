@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@onready var sfx_player = $"../SfxPlayer"
@onready var mesh = $"../MeshInstance3D"

var radio_on = false
var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	mesh.visible = false
	#toggle_radio()
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))

func toggle_radio():
	sfx_player.play()

	if not radio_on:
		await sfx_player.finished
		await get_tree().create_timer(1).timeout
		Room3GameEvents.emit_signal("start_music")
		radio_on = true
	else:
		Room3GameEvents.emit_signal("stop_music")
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

func _on_final():
	Room3GameEvents.emit_signal("stop_music")
	radio_on = false
