@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"

@export var anim_name: String = "Open"
@export var anim: AnimationPlayer
@export var audio: AudioStreamPlayer3D
@export var max_interaction_distance := 1.2


@onready var event_emitter := Room3GameEvents
const OPEN_SIGNAL_NAME := "drawer_2_unlocked"

@onready var highlight = $Highlight
var is_open := false

func _ready():
	if Engine.is_editor_hint():
		return

	highlight.visible = false
	connect("pointer_event", Callable(self, "_on_pointer_event"))


func _on_pointer_event(event: XRToolsPointerEvent):
	match event.event_type:
		XRToolsPointerEvent.Type.ENTERED:
			highlight.visible = true

		XRToolsPointerEvent.Type.EXITED:
			highlight.visible = false

		XRToolsPointerEvent.Type.PRESSED:
			var pointer_pos = event.pointer.global_position
			var my_pos = global_position

			if pointer_pos.distance_to(my_pos) > max_interaction_distance:
				return
				
			highlight.visible = false

			if audio:
				audio.play()

			if not is_open:
				_open_drawer()
			else:
				_close_drawer()

			await anim.animation_finished
			highlight.visible = true


func _open_drawer():
	is_open = true
	anim.play(anim_name)

	if event_emitter:
		event_emitter.emit_signal(OPEN_SIGNAL_NAME)


func _close_drawer():
	is_open = false
	anim.play_backwards(anim_name)
