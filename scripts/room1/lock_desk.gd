extends Area3D


@onready var left_pointer: XRToolsFunctionPointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
@onready var right_pointer: XRToolsFunctionPointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")

var viewport: XRToolsViewport2DIn3D

var original_position: Vector3 = Vector3(-0.1, 0.25, 0)
var hidden_position: Vector3 = Vector3(0, -10, 0)

func _ready():
	viewport = get_parent().get_node("Viewport2Din3D")
	viewport.transform.origin = hidden_position
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print(body.name)
	if body.name == "PlayerBody":
		viewport.transform.origin = original_position
		left_pointer.visible = true
		right_pointer.visible = true

func _on_body_exited(body):
	if body.name == "PlayerBody":
		viewport.transform.origin = hidden_position
		left_pointer.visible = false
		right_pointer.visible = false
