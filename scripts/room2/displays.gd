extends Node3D

@onready var anim_player: AnimationPlayer = $Sketchfab_model/AnimationPlayer

func _ready():
	Room2GameEvents.connect("keypad_true", Callable(self, "_on_keypad_unlocked"))
	Room2GameEvents.connect("computer_unlocked", Callable(self, "_on_computer_unlocked"))

func _on_keypad_unlocked():
	$info.hide()
	if anim_player:
		anim_player.play("flashing")

func _on_computer_unlocked():
	if anim_player:
		anim_player.stop()
