extends Area3D


@onready var left_pointer: XRToolsFunctionPointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
@onready var right_pointer: XRToolsFunctionPointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")

var viewport: XRToolsViewport2DIn3D

func _ready():
	viewport = get_parent().get_node("Viewport2Din3D")
	viewport.visible = false
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	

func _on_body_entered(body):
	if body.name == "PlayerBody":
		left_pointer.visible = true
		right_pointer.visible = true

func _on_body_exited(body):
	if body.name == "PlayerBody":
		viewport.visible = false
		left_pointer.visible = false
		right_pointer.visible = false
