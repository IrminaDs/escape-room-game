extends Node3D

@onready var anim_player: AnimationPlayer = $Chest3D/Sketchfab_Scene/AnimationPlayer
@onready var lock_area: Node3D = $Lock

func _ready():
	Room1GameEvents.connect("chest_unlocked", Callable(self, "_on_chest_unlocked"))

func _on_chest_unlocked():
	if anim_player:
		anim_player.play("Armature|A_Open")
	if lock_area:
		lock_area.queue_free()
