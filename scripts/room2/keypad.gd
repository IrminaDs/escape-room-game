extends Node3D

# @onready var anim_player: AnimationPlayer = $Chest3D/Sketchfab_Scene/AnimationPlayer
@onready var lock_area: Node3D = $Lock

func _ready():
	Room2GameEvents.connect("keypad_true", Callable(self, "_on_keypad_unlocked"))

func _on_keypad_unlocked():
#	if anim_player:
#		anim_player.play("Armature|A_Open")
	if lock_area:
		lock_area.queue_free()
