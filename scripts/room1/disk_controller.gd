extends Node

@onready var parent_pickable = get_parent()
@onready var inner_disk = $"../CSGCombiner3D/InnerDisk"
@onready var left_controller: XRController3D = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController")
@onready var right_controller: XRController3D = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController")

var is_held = false
var rotation_speed = 45.0

const ROTATE_LEFT_ACTION = "rotate_left"
const ROTATE_RIGHT_ACTION = "rotate_right"

func _ready():
	parent_pickable.connect("picked_up", Callable(self, "_on_picked_up"))
	parent_pickable.connect("dropped", Callable(self, "_on_dropped"))

func _on_picked_up(_by):
	is_held = true

func _on_dropped(_by):
	is_held = false

func _process(delta):
	if not is_held:
		return

	if left_controller.is_button_pressed("trigger"):
		inner_disk.rotate_y(deg_to_rad(rotation_speed * delta))
	elif right_controller.is_button_pressed("trigger"):
		inner_disk.rotate_y(deg_to_rad(-rotation_speed * delta))
