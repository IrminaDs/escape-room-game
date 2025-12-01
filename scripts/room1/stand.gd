extends StaticBody3D


@export var item_name: String = "Ceasar"
@onready var snap_zone: XRToolsSnapZone = $"SnapZone"
@onready var collision: CollisionShape3D = $"CollisionShape3D"
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer
@onready var move_audio: AudioStreamPlayer3D = $MovingSound

func _ready():
	if snap_zone.has_signal("has_picked_up"):
		snap_zone.connect("has_picked_up", Callable(self, "_on_picked_up"))
	Room1GameEvents.connect("book_opened", Callable(self, "_on_book_opened"), CONNECT_ONE_SHOT)
	
	self.visible = false
	snap_zone.enabled = false
	collision.disabled = true
	
func _on_book_opened():
	self.visible = true
	snap_zone.enabled = true
	collision.disabled = false
	audio.play()
	
func _on_picked_up(pickable: XRToolsPickable):
	if pickable.name == item_name:
		pickable.enabled = false
		
		var static_copy := StaticBody3D.new()
		static_copy.name = pickable.name
		static_copy.transform = pickable.global_transform
		static_copy.transform.origin.y += 0.5
		
		for child in pickable.get_children():
			if child.name == "CollisionShape3D" or child.name == "Sketchfab_Scene":
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
		move_audio.play()
		
		Room1GameEvents.emit_signal("ceasar_placed")

		snap_zone.enabled = false
