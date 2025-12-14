extends Node3D

var current_scene: Node = null
var loading_scene := preload("res://scenes/loading_screen.tscn")  

func _ready():
	load_scene("res://scenes/menu/Menu.tscn")

func load_scene(path: String) -> void:
	var load_scr = loading_scene.instantiate()
	add_child(load_scr)
	
	var player = get_node("/root/Main/Player")
	var origin = player.get_node("XROrigin3D")
	var body = origin.get_node("PlayerBody")

	var t = Transform3D()
	t.origin = Vector3(0, 0, 0)
	t.basis = Basis()
	body.teleport(t)
	
	if current_scene:
		current_scene.queue_free()

	ResourceLoader.load_threaded_request(path)

	while true:
		var progress : Array = []
		var status = ResourceLoader.load_threaded_get_status(path, progress)

		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var scene_res = ResourceLoader.load_threaded_get(path)
			var new_scene = scene_res.instantiate()
			add_child(new_scene)
			current_scene = new_scene
			break
		elif status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			push_error("Failed to load " + path)
			break
		await get_tree().process_frame
	
	load_scr.queue_free()
