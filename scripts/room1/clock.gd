extends StaticBody3D


@onready var animation: AnimationPlayer = $"Sketchfab_Scene/AnimationPlayer"
@onready var pendulum: Node = $"Sketchfab_Scene/Sketchfab_model/wall_clock_fbx/Object_2/RootNode/wall_clock/wall_clock_pendulum"
@onready var minutes: Node = $"Sketchfab_Scene/Sketchfab_model/wall_clock_fbx/Object_2/RootNode/wall_clock/wall_clock_arrow_minutes"
@onready var hours: Node = $"Sketchfab_Scene/Sketchfab_model/wall_clock_fbx/Object_2/RootNode/wall_clock/wall_clock_arrow_hour"
@onready var ticking: AudioStreamPlayer3D = $TickingAudio
@onready var bell: AudioStreamPlayer = $BellAudio

func _ready() -> void:
	var stream = load("res://models/Room1/sounds/256477__rollo145__ticking-clock-large.ogg")
	stream.loop = true
	ticking.stream = stream
	ticking.play()
	
	Room1GameEvents.connect("ceasar_placed", Callable(self, "_on_ceasar_placed"))

func _on_ceasar_placed():
	animation.stop()
	
	pendulum.rotation.z = deg_to_rad(0)
	
	minutes.transform.origin = Vector3(24, 9, -2.083)
	minutes.rotation.z = deg_to_rad(39)
	
	hours.transform.origin = Vector3(-33, 19, -2.083)
	hours.rotation.z = deg_to_rad(-60)
	
	ticking.stop()
	await get_tree().create_timer(0.5).timeout
	bell.play()
