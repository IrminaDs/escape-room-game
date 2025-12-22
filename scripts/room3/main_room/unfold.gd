extends Node

@onready var parent_pickable = get_parent()
@onready var left_controller: XRController3D = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController")
@onready var right_controller: XRController3D = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController")

var is_held = false
var triggers_pressed = false
var initial_distance: float = 0.0
var transformed = false

var left_was_pressed = false
var right_was_pressed = false

const DISTANCE_THRESHOLD := 0.25

var paper_sheet_scene: PackedScene = preload("res://scenes/room3/main_room/rsa.tscn")

func _ready():
	parent_pickable.connect("picked_up", Callable(self, "_on_picked_up"))
	parent_pickable.connect("dropped", Callable(self, "_on_dropped"))

func _on_picked_up(_by):
	is_held = true

func _on_dropped(_by):
	is_held = false
	triggers_pressed = false
	initial_distance = 0.0

func _process(delta):
	if transformed or not is_held:
		return

	var left_pressed = left_controller.is_button_pressed("trigger")
	var right_pressed = right_controller.is_button_pressed("trigger")

	if left_pressed and not left_was_pressed:
		triggers_pressed = false
	if right_pressed and not right_was_pressed:
		triggers_pressed = false

	if left_pressed and right_pressed:
		if not triggers_pressed:
			triggers_pressed = true
			initial_distance = left_controller.global_transform.origin.distance_to(right_controller.global_transform.origin)
	else:
		triggers_pressed = false
		initial_distance = 0.0

	if triggers_pressed:
		var current_distance = left_controller.global_transform.origin.distance_to(right_controller.global_transform.origin)
		if current_distance - initial_distance > DISTANCE_THRESHOLD:
			_transform_to_sheet()

	left_was_pressed = left_pressed
	right_was_pressed = right_pressed

func _transform_to_sheet():
	if transformed:
		return
	transformed = true

	var sheet = paper_sheet_scene.instantiate() as Node3D
	sheet.scale = Vector3.ONE
	get_tree().get_current_scene().add_child(sheet)

	sheet.global_transform = parent_pickable.global_transform

	if sheet.has_signal("picked_up"):
		sheet.emit_signal("picked_up", null)

	parent_pickable.queue_free()
