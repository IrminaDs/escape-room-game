extends Node


@onready var grab := get_parent()

var chest: bool = false

func _ready():
	_disable_grab()
	
	Room1GameEvents.connect("chest_unlocked", Callable(self, "_on_chest_unlocked"))
	Room1GameEvents.connect("picture_open", Callable(self, "_on_picture_open"))

func _on_chest_unlocked():
	chest = true

func _on_picture_open():
	if chest:
		_enable_grab()
		Room1GameEvents.disconnect("picture_open", Callable(self, "_on_picture_open"))

func _disable_grab():
	if grab:
		grab.enabled = false

func _enable_grab():
	if grab:
		grab.enabled = true
