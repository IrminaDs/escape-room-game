extends Node

@export var keyboard_root: Node3D

var current_target: Node = null

func _ready():
	Room3GameEvents.show_keyboard.connect(_on_show_keyboard)
	Room3GameEvents.hide_keyboard.connect(_on_hide_keyboard)
	keyboard_root.visible = false

func _on_show_keyboard(target: Node) -> void:
	current_target = target
	keyboard_root.visible = true

func _on_hide_keyboard() -> void:
	keyboard_root.visible = false
	current_target = null
