extends Node3D

@onready var anim_player: AnimationPlayer = $StaticBody3D/Sketchfab_Scene/AnimationPlayer
@onready var lock_area: Node3D = $Lock/InteractionZone
@onready var viewport: Node3D = $Lock/Viewport2Din3D

func _ready():
	Room1GameEvents.connect("desk_unlocked", Callable(self, "_on_desk_unlocked"))

func _on_desk_unlocked():
	if anim_player:
		anim_player.play("Open")
	if lock_area:
		lock_area.queue_free()
	if viewport:
		viewport.queue_free()
