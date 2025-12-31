extends Node3D

@onready var anim_player: AnimationPlayer = $Sketchfab_Scene/AnimationPlayer

func _ready():
	Room2GameEvents.connect("computer_unlocked", Callable(self, "_on_computer_unlocked"))

func _on_computer_unlocked():
	if anim_player:
		anim_player.play("Plane_003Action_001")
