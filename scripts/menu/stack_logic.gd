@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@export var path: String = "res://scenes/Room1/Room1.tscn"
@export var room_events: String = "/root/Room1GameEvents"
@export var text: String = "Szyfry:\n- Tablica Polibiusz\n- Szyfr Cezara\n- Szyfr Vigenere'a"

@onready var main_light = $"../MainLight"
@onready var ilumination = $"../FakeIlumination"
@onready var sec_light = $"../SecondaryLight"
@onready var stack = $"../Stack"
@onready var label = $"../Label3D"
@onready var audio = $"../AudioStreamPlayer3D"

var left_pointer: XRToolsFunctionPointer
var right_pointer: XRToolsFunctionPointer
var room = false
var events

func _ready():
	if Engine.is_editor_hint():
		return
	
	left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
	right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")
	
	events = get_node(room_events)
	if events.room_finished:
		room = true
		label.text = text
		main_light.light_energy = 16
		sec_light.visible = true
		ilumination.visible = true
		stack.visible = true
		label.visible = false
	else:
		main_light.light_energy = 1
		sec_light.visible = false
		ilumination.visible = false
		stack.visible = false
		label.visible = false
	
	connect("pointer_event", Callable(self, "_on_pointer_event"))

func _on_pointer_event(event):
	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			if room:
				label.visible = true
			else:
				main_light.light_energy = 16
				sec_light.visible = true
				ilumination.visible = true
				label.visible = true
				audio.play()
		XRToolsPointerEvent.Type.EXITED:
			if room:
				label.visible = false
			else:
				main_light.light_energy = 1
				sec_light.visible = false
				ilumination.visible = false
				label.visible = false
		XRToolsPointerEvent.Type.PRESSED:
			get_node("/root/Main").load_scene(path)
