extends Node

@onready var viewport: XRToolsViewport2DIn3D = get_parent()
@onready var left_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController/FunctionPointer")
@onready var right_pointer = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController/FunctionPointer")

func _ready():
	Room3GameEvents.show_screen.connect(_on_show_screen)
	viewport.visible = true
	await get_tree().create_timer(5).timeout
	Room3GameEvents.show_screen.emit("first_message")
	

func _on_show_screen(screen_id: String):
	match screen_id:
		"first_message":
			viewport.scene = load("res://scenes/room3/main_room/screens/screen_intro_message.tscn")
		"second_message":
			viewport.scene = load("res://scenes/room3/main_room/screens/screen_2_message.tscn")
		"configuration_screen":
			viewport.scene = load("res://scenes/room3/main_room/screens/screen_configuration.tscn")
		"last_message":
			viewport.scene = load("res://scenes/room3/main_room/screens/screen_last_message.tscn")
		"door_schema":
			viewport.scene = load("res://scenes/room3/main_room/screens/screen_door_schema.tscn")
		"last_screen":
			viewport.scene = load("res://scenes/room3/main_room/screens/screen_last.tscn")
