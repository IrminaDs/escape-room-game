extends Node3D


var camera: Camera3D

func _ready():
	var main = get_tree().root.get_node("Main")
	var player = main.get_node("Player")
	camera = player.find_child("XRCamera3D", true, false)
	
func _process(delta):
	if camera:
		look_at(camera.global_transform.origin, Vector3.UP)
