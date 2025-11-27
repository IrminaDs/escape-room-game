extends Node


@export var sig_name: String

@onready var grab := get_parent()

func _ready():
	_disable_grab()
	
	Room1GameEvents.connect(sig_name, Callable(self, "_on_chest_unlocked"))

func _on_chest_unlocked():
	_enable_grab()

func _disable_grab():
	if grab:
		grab.enabled = false

func _enable_grab():
	if grab:
		grab.enabled = true
