extends Node

@onready var parent_pickable = get_parent()
@onready var inner_disk = $"../CSGCombiner3D/InnerDisk"
@onready var label = $"../Label3D"
@onready var left_controller: XRController3D = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController")
@onready var right_controller: XRController3D = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController")

var is_held = false
var offset := 0 
var alphabet_size := 26
var step := deg_to_rad(360.0 / 26)
var left_was_pressed := false
var right_was_pressed := false

const ROTATE_LEFT_ACTION = "rotate_left"
const ROTATE_RIGHT_ACTION = "rotate_right"

func _ready():
	parent_pickable.connect("picked_up", Callable(self, "_on_picked_up"))
	parent_pickable.connect("dropped", Callable(self, "_on_dropped"))
	_update_label()

func _on_picked_up(_by):
	is_held = true

func _on_dropped(_by):
	is_held = false

func _process(delta):
	if not is_held:
		return
	
	var left_pressed = left_controller.is_button_pressed("trigger")
	var right_pressed = right_controller.is_button_pressed("trigger")
		
	if left_pressed and not left_was_pressed:
		_rotate_disk(1)
	elif right_pressed and not right_was_pressed:
		_rotate_disk(-1)
	
	left_was_pressed = left_pressed
	right_was_pressed = right_pressed

func _rotate_disk(direction: int):
	inner_disk.rotate_y(step * direction)
	offset = (offset + direction + alphabet_size) % alphabet_size
	_update_label()

func _update_label():
	label.text = "%d" % [offset]
