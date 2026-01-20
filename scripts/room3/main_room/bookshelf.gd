extends Area3D

var viewport: XRToolsViewport2DIn3D

func _ready():
	viewport = get_parent().get_node("Viewport2Din3D")
	viewport.visible = false
	
	connect("body_exited", Callable(self, "_on_body_exited"))
	

func _on_body_exited(body):
	if body.name == "PlayerBody":
		viewport.visible = false
