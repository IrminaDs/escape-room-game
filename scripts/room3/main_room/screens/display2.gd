extends Node3D

func _ready():
	Room3GameEvents.glitch.connect(_on_glitch)
	Room3GameEvents.glitch_finished.connect(_on_glitch_finished)

func _on_glitch():
	self.visible = true
	$AnimationPlayer.play("Blink")

func _on_glitch_finished():
	self.visible = false 
