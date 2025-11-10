extends StaticBody3D


@export var item_name: String = "Ceasar"
@onready var snap_zone: XRToolsSnapZone = $"SnapZone"

func _ready():
	if snap_zone.has_signal("has_picked_up"):
		snap_zone.connect("has_picked_up", Callable(self, "_on_picked_up"))
	
func _on_picked_up(pickable: XRToolsPickable):
	if pickable.name == item_name:
		pickable.enabled = false
		
		var static_copy := StaticBody3D.new()
		static_copy.name = pickable.name
		static_copy.transform = pickable.global_transform
		static_copy.transform.origin.y += 0.25
		
		for child in pickable.get_children():
			static_copy.add_child(child.duplicate())

		var parent = pickable.get_parent()
		parent.add_child(static_copy)
		parent.remove_child(pickable)
		pickable.queue_free()
		
		await get_tree().create_timer(0.5).timeout
		var tween = get_tree().create_tween()
		tween.tween_property(
			static_copy,
			"rotation:y",
			static_copy.rotation.y + deg_to_rad(30),
			1
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

		snap_zone.enabled = false
