extends Node

@onready var viewport: XRToolsViewport2DIn3D = get_parent()

var FIRST_MESSAGE = preload("res://scenes/room3/main_room/screens/screen_intro_message.tscn")
var SECOND_MESSAGE = preload("res://scenes/room3/main_room/screens/screen_2_message.tscn")
var SCREEN_CONFIGURATION = preload("res://scenes/room3/main_room/screens/screen_configuration.tscn")
var SCREEN_LAST_MESSAGE = preload("res://scenes/room3/main_room/screens/screen_last_message.tscn")
var SCREEN_DOOR_SCHEMA = preload("res://scenes/room3/main_room/screens/screen_door_schema.tscn")
var SCREEN_LAST = preload("res://scenes/room3/main_room/screens/screen_last.tscn")

func _ready():
	Room3GameEvents.show_screen.connect(_on_show_screen)
	viewport.visible = true
	#Room3GameEvents.show_screen.emit("first_message")

func _on_show_screen(screen_id: String):
	match screen_id:
		"first_message":
			viewport.scene = FIRST_MESSAGE
		"second_message":
			viewport.scene = SECOND_MESSAGE
		"configuration_screen":
			viewport.scene = SCREEN_CONFIGURATION
		"last_message":
			viewport.scene = SCREEN_LAST_MESSAGE
		"door_schema":
			viewport.scene = SCREEN_DOOR_SCHEMA
		"last_screen":
			viewport.scene = SCREEN_LAST
