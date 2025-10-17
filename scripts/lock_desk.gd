extends Area3D

@export var ui_scene : PackedScene = preload("res://scenes/Room1/UILockDesk.tscn")
var ui_instance : Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

var player_in_area := false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		if ui_instance == null:
			ui_instance = ui_scene.instantiate()
			get_tree().root.add_child(ui_instance)
			
			ui_instance.setup_ui_for_player(player_in_area_reference, self.get_parent())

var player_in_area_reference : CharacterBody3D = null

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true
		player_in_area_reference = body

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
		player_in_area_reference = null
