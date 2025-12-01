extends Node3D

@onready var anim_player: AnimationPlayer = $StaticBody3D/Sketchfab_Scene/AnimationPlayer
@onready var lock_area: Node3D = $Lock/InteractionZone
@onready var viewport: Node3D = $Lock/Viewport2Din3D
@onready var audio: AudioStreamPlayer3D = $"StaticBody3D/Sketchfab_Scene/Sketchfab_model/f1bc8c6dbdca48a59913f281bf51c70b_fbx/RootNode/Desk_low/Draw 1_low/Area3D/AudioStreamPlayer3D"

func _ready():
	Room1GameEvents.connect("desk_unlocked", Callable(self, "_on_desk_unlocked"))

func _on_desk_unlocked():
	if anim_player:
		anim_player.play("Open")
	if audio:
		audio.play()
	if lock_area:
		lock_area.queue_free()
	if viewport:
		viewport.queue_free()
