extends Node

@onready var parent_node = get_parent()
@onready var anim_player: AnimationPlayer = $"../Sketchfab_Scene/AnimationPlayer"

var first_grab = true

func _ready():
	if parent_node.has_signal("grabbed"):
		parent_node.connect("grabbed", Callable(self, "_on_grabbed"))
	if parent_node.has_signal("released"):
		parent_node.connect("released", Callable(self, "_on_released"))

func _on_grabbed(pickable, _by):
	if pickable != parent_node:
		return

	anim_player.play("Scene")

func _on_released(pickable, _by):
	if pickable != parent_node:
		return

	anim_player.play_backwards()
