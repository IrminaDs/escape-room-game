extends Node3D

var current_scene: Node = null

func _ready():
	load_scene("res://scenes/Menu/Menu.tscn")

func load_scene(path: String):
	if current_scene:
		current_scene.queue_free()

	var new_scene = load(path).instantiate()
	add_child(new_scene)
	current_scene = new_scene
