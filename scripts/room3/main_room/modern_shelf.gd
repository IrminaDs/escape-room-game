extends StaticBody3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var lock_area: Node3D = $Lock

func _ready():
	Room3GameEvents.connect("modern_shelf_unlocked", Callable(self, "_shelf_unlocked"))

func _shelf_unlocked():
	if anim_player:
		anim_player.play("Armature|Open")
	if lock_area:
		lock_area.queue_free()
