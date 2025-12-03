extends Node


@onready var grab := get_parent()
@onready var highlight = get_parent().get_node("HighlightRing")

var lock: bool = false

func _ready():
	_disable_grab()
	
	Room1GameEvents.connect("clock_lock", Callable(self, "_on_clock_lock"))
	Room1GameEvents.connect("picture_open", Callable(self, "_on_picture_open"))

func _on_clock_lock():
	lock = true

func _on_picture_open():
	if lock:
		_enable_grab()
		Room1GameEvents.disconnect("picture_open", Callable(self, "_on_picture_open"))

func _disable_grab():
	if grab:
		grab.enabled = false

func _enable_grab():
	if grab:
		grab.enabled = true
