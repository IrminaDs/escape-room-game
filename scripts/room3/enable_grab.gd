extends Node

enum Rooms { Room1, Room3 }

@export var room: Rooms            
@export var signal_name: String    

@onready var grab := get_parent()

func _ready():
	_disable_grab()
	var emitter = _get_emitter()
	if emitter:
		emitter.connect(signal_name, Callable(self, "_on_signal_received"))

func _on_signal_received():
	_enable_grab()

func _disable_grab():
	if grab:
		grab.enabled = false

func _enable_grab():
	if grab:
		grab.enabled = true

func _get_emitter():
	match room:
		Rooms.Room1:
			return Room1GameEvents
		Rooms.Room3:
			return Room3GameEvents
		_:
			return null
