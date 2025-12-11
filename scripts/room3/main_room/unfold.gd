extends Node

@export var pickable: XRToolsPickable
@export var sheet_scene: PackedScene
@export var trigger_threshold := 0.75
@export var stretch_threshold := 0.35

var left_hand: XRController3D = null
var right_hand: XRController3D = null
var unfolded := false


func _ready():
	if not pickable:
		pickable = get_parent() as XRToolsPickable

	pickable.grabbed.connect(_on_grabbed)

func _on_grabbed(controller: XRController3D, by_handle: bool):
	if controller.is_left_hand():
		left_hand = controller
	else:
		right_hand = controller


func _on_released(controller: XRController3D, by_handle: bool):
	if controller == left_hand:
		left_hand = null
	elif controller == right_hand:
		right_hand = null


func _physics_process(_delta):
	if unfolded:
		return

	if not (left_hand and right_hand):
		return

	var tl := left_hand.get_float("trigger")
	var trir := right_hand.get_float("trigger")

	if tl < trigger_threshold or trir < trigger_threshold:
		return

	var dist := left_hand.global_position.distance_to(right_hand.global_position)

	if dist > stretch_threshold:
		unfold()


func unfold():
	if unfolded:
		return
	unfolded = true

	var tween = pickable.create_tween()
	tween.tween_property(pickable, "scale", pickable.scale * 2, 0.20)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.finished.connect(_spawn_sheet)


func _spawn_sheet():
	var sheet = sheet_scene.instantiate()
	sheet.global_transform = pickable.global_transform
	pickable.get_parent().add_child(sheet)

	pickable.queue_free()
