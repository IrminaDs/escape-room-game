extends Node3D

@export var interaction_distance : float = 0.6
@export var move_offset : Vector3 = Vector3(0, 0.25, -0.25)
@export var rotation_offset : Vector3 = Vector3(90, 0, 0)
@export var animation_time : float = 0.5

var is_open : bool = false
var was_pressed : bool = false
var controller_near : bool = false

@onready var highlight_mesh : MeshInstance3D = $Highlight
@onready var start_transform : Transform3D = global_transform
@onready var target_transform : Transform3D = get_target_transform()

func _ready():
	highlight_mesh.visible = false

func _process(delta):
	var was_near = controller_near
	controller_near = false
	var pressed = false

	for controller in get_tree().get_nodes_in_group("XRControllers"):
		var distance = global_transform.origin.distance_to(controller.global_transform.origin)
		if distance <= interaction_distance:
			controller_near = true
			pressed = controller.is_button_pressed("trigger")
			break

	if controller_near != was_near:
		highlight_mesh.visible = controller_near
		
		if not controller_near and was_near and is_open:
			toggle_picture()

	if controller_near and pressed and not was_pressed:
		toggle_picture()
	was_pressed = pressed


func get_target_transform() -> Transform3D:
	var t = start_transform
	t.origin += move_offset
	t.basis = Basis.from_euler(rotation_offset * deg_to_rad(1)) * start_transform.basis
	return t


func toggle_picture():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	var target : Transform3D
	if is_open:
		target = start_transform
	else:
		target = target_transform
		if self.name == 'Duck':
			Room1GameEvents.emit_signal("picture_open")

	tween.tween_property(self, "global_transform", target, animation_time)
	is_open = not is_open
