extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var lock_area: Node3D = $Lock

func _ready():
	Room3GameEvents.glitch.connect(_automatic_door_close)
	Room3GameEvents.correct_schema.connect(_automatic_door_unlock)

func _automatic_door_unlock():
	if anim_player:
		anim_player.play("Armature|Open")
	if lock_area:
		lock_area.queue_free()

func _automatic_door_close():
	if anim_player:
		anim_player.play_backwards("Armature|Open")
