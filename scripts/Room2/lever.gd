extends Node3D

@export var target_light: $Build/Objects/DirectionalLight3D
@export var activated_color: Color = Color(1, 0, 0)
@export var deactivated_color: Color = Color(1, 1, 1)

@onready var anim: AnimationPlayer = $"Sketchfab_model/Breaker Sketchfab_fbx/RootNode/Lever_v2_Box/AnimationPlayer"
var is_activated: bool = false

func interact():
	if not target_light:
		push_warning("No light assigned to lever.")
		return

	is_activated = !is_activated

	if is_activated:
		anim.play("pull_up")
		target_light.light_color = activated_color
	else:
		anim.play("reset")
		target_light.light_color = deactivated_color
