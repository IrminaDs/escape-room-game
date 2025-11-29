extends Node

@onready var parent = get_parent()
@onready var anim_player: AnimationPlayer = $"../Sketchfab_Scene/AnimationPlayer"

func _ready():	
	if parent.has_signal("grabbed"):
		parent.connect("grabbed", Callable(self, "_on_grabbed"))
		
	if parent.has_signal("released"):
		parent.connect("released", Callable(self, "_on_released"))

func _on_grabbed(pickable, by):
	if pickable == get_parent():
		var duration = 1.7 - 0.8
		anim_player.play("Demo")
		anim_player.seek(0.8, true)
		await get_tree().create_timer(duration).timeout
		anim_player.stop()
		anim_player.seek(1.7, true)

func _on_released(pickable, by):
	if pickable == get_parent():
		var duration = anim_player.get_animation("Demo").length - 2.5
		anim_player.play("Demo")
		anim_player.seek(2.5, true)
		await get_tree().create_timer(duration).timeout
		anim_player.stop()
