extends Node


@export var position: Vector3
@export var degrees: int

func _ready() -> void:	
	var player = get_node("/root/Main/Player")
	var origin = player.get_node("XROrigin3D")
	var body = origin.get_node("PlayerBody")

	var t = Transform3D()
	t.origin = position
	t.basis = Basis(Vector3.UP, deg_to_rad(degrees))
	body.teleport(t)
