extends Node3D

@onready var error := $Sketchfab_model/Holo_Table_fbx/Object_2/RootNode/Hologram2
@onready var normal := $Sketchfab_model/Holo_Table_fbx/Object_2/RootNode/Hologram
@onready var anim := $AnimationPlayer

func _ready() -> void:	
	normal.visible = false	
	error.visible = true
	
	Room3GameEvents.glitch_finished.connect(_on_glitch_finished)

func _on_glitch_finished():
	error.visible = false
	normal.visible = true
	anim.play("Hologram | Rotation")
	error.queue_free()
