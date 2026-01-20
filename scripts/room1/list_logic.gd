extends Node


@export var path: String = ""

@onready var parent_pickable = get_parent()
@onready var floor_check = parent_pickable.get_node("ShapeCast3D")

func _ready():
	var viewport = $"../Viewport2Din3D"
	if path != "":
		await _wait_for_ui_instance()
		var ui = viewport.get_node("Viewport").get_child(0)
		ui._set_texture(path)
		ui._update_texture()
	
	viewport.visible = false
	
	if parent_pickable.has_signal("grabbed"):
		parent_pickable.connect("grabbed", Callable(self, "_on_grabbed"))
		
	if parent_pickable.has_signal("released"):
		parent_pickable.connect("released", Callable(self, "_on_released"))

func _physics_process(delta):
	floor_check.force_shapecast_update()
	
	if floor_check.is_colliding():
		var collision_y = floor_check.get_collision_point(0).y
		var pos = parent_pickable.global_transform.origin

		pos.y = collision_y + 0.015
		parent_pickable.global_transform.origin = pos
		
		if parent_pickable.has_method("set_linear_velocity"):
			parent_pickable.set_linear_velocity(Vector3.ZERO)

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
