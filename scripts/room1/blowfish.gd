extends Node3D


var camera: Camera3D

func _ready():
	camera = get_viewport().get_camera_3d()
	
func _process(delta):
	if camera:
		look_at(camera.global_transform.origin, Vector3.UP)
