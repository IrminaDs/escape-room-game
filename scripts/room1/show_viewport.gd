extends Node

@export var path: String = ""

@onready var parent_pickable = get_parent()

func _ready():
	if path != "":
		var viewport = $"../Viewport2Din3D"
		await _wait_for_ui_instance()
		var ui = viewport.get_node("Viewport").get_child(0)
		ui._set_texture(path)
		ui._update_texture()
	
	$"../Viewport2Din3D".visible = false
	
	if parent_pickable.has_signal("grabbed"):
		parent_pickable.connect("grabbed", Callable(self, "_on_grabbed"))
		
	if parent_pickable.has_signal("released"):
		parent_pickable.connect("released", Callable(self, "_on_released"))

func _wait_for_ui_instance():
	var subvp = $"../Viewport2Din3D".get_node("Viewport")
	while subvp.get_child_count() == 0:
		await get_tree().process_frame

func _on_grabbed(pickable, by):
	if pickable == get_parent():
		$"../Viewport2Din3D".visible = true

func _on_released(pickable, by):
	if pickable == get_parent():
		$"../Viewport2Din3D".visible = false
