extends Area3D


@onready var label1: Label3D = $"../Label3D"
@onready var label2: Label3D = $"../Label3D2"

func _ready() -> void:
	label1.visible = false
	label2.visible = false
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "PlayerBody":
		label1.visible = true
		label2.visible = true

func _on_body_exited(body):
	if body.name == "PlayerBody":
		label1.visible = false
		label2.visible = false
