extends Node


@onready var parent = get_parent()
@onready var floor_check = parent.get_node("ShapeCast3D")

func _ready():
	parent.enabled = false
	parent.set_collision_mask_value(1, false)
	
	parent.connect("grabbed", Callable(self, "_on_grabed"))
	parent.connect("dropped", Callable(self, "_on_dropped"))

func _physics_process(delta):
	floor_check.force_shapecast_update()
	
	if floor_check.is_colliding():
		var collision_y = floor_check.get_collision_point(0).y
		var pos = parent.global_transform.origin

		pos.y = collision_y + 0.01
		parent.global_transform.origin = pos
		
		if parent.has_method("set_linear_velocity"):
			parent.set_linear_velocity(Vector3.ZERO)

func _on_grabed(pickable, by):
	if pickable == get_parent():
		floor_check.set_collision_mask_value(1, true)
		Room1GameEvents.emit_signal("final")
		parent.disconnect("grabbed", Callable(self, "_on_grabed"))

func _on_dropped(pickable):
	if pickable == get_parent():
		parent.set_collision_mask_value(1, true)
