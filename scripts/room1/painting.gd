@tool
extends "res://addons/godot-xr-tools/objects/interactable_area.gd"


@onready var label1: Label3D = $"../Label3D"
@onready var label2: Label3D = $"../Label3D2"
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
	
	label1.visible = false
	label2.visible = false
	mesh.visible = false
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	connect("pointer_event", Callable(self, "_on_pointer_event"))
	Room1GameEvents.connect("album_taken", Callable(self, '_on_album_taken'))

func _on_album_taken():
	album = true

func _on_body_entered(body):
	if body.name == "PlayerBody":
		label1.visible = true
		label2.visible = true
		if album and is_mesh:
			mesh.visible = true
			inter = true

func _on_body_exited(body):
	if body.name == "PlayerBody":
		label1.visible = false
		label2.visible = false
		if album and is_mesh:
			mesh.visible = false
			inter = false

func _on_pointer_event(event):	
	if done or !inter:
		return
	
	match event.event_type:
		XRToolsPointerEvent.Type.PRESSED:
			mesh.queue_free()
			is_mesh = false
			
			anim.play("Photo")
			var photo = get_parent().get_node("Photo")
			photo.enabled = true
			
			done = true
