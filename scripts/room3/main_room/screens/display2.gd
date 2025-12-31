extends Node3D

@onready var anim := $AnimationPlayer

func _ready():
	Room3GameEvents.glitch.connect(_on_glitch)
	Room3GameEvents.glitch_finished.connect(_on_glitch_finished)

func _on_glitch():
	self.visible = true
	anim.play("Blink")

func _on_glitch_finished():
	self.visible = false
	await get_tree().create_timer(12).timeout
	self.queue_free()
