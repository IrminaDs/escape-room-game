extends Node


func _ready() -> void:	
	var player = get_node("/root/Main/Player")
	var origin = player.get_node("XROrigin3D")
	var body = origin.get_node("PlayerBody")

	var t = Transform3D()
	t.origin = Vector3(0, 0, -0.25)
	t.basis = Basis(Vector3.UP, deg_to_rad(180))
	body.teleport(t)

func _process(delta: float) -> void:
	var player = get_node("/root/Main/Player")
