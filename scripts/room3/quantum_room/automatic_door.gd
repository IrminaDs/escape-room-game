extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var lock_area: Node3D = $DoorLocked

func _ready():
	Room3GameEvents.connect("automatic_door_unlocked", Callable(self, "_automatic_door_unlocked"))

func _automatic_door_unlocked():
	if anim_player:
		anim_player.play("Armature|Open")
	if lock_area:
		lock_area.queue_free()
