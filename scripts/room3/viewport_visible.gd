extends Area3D

var viewport: XRToolsViewport2DIn3D

@export var original_position: Vector3 = Vector3(-0.1, 0.25, 0)
var hidden_position: Vector3 = Vector3(0, -15, 0)

func _ready():
	viewport = get_parent().get_node("Viewport2Din3D")
	viewport.transform.origin = hidden_position
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	
func _on_body_entered(body):
	if body.name == "PlayerBody":
		viewport.transform.origin = original_position

func _on_body_exited(body):
	if body.name == "PlayerBody":
		viewport.transform.origin = hidden_position
