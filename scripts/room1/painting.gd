extends Area3D


@onready var label1: Label3D = $"../Label3D"
@onready var label2: Label3D = $"../Label3D2"
@onready var area: = $"../Area3D2"

var album = false
var is_mesh = true

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	label1.visible = false
	label2.visible = false
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	Room1GameEvents.connect("album_taken", Callable(self, '_on_album_taken'))

func _on_album_taken():
	album = true

func _on_body_entered(body):
	if body.name == "PlayerBody":
		label1.visible = true
		label2.visible = true
		if album and is_mesh:
			area.inter = true

func _on_body_exited(body):
	if body.name == "PlayerBody":
		label1.visible = false
		label2.visible = false
		if album and is_mesh:
			area.inter = false
