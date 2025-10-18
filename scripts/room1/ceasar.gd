extends Node  # lub nic, jeśli tylko attachujesz

@onready var grab := get_parent()

func _ready():
	_disable_grab()
	Room1GameEvents.connect("chest_unlocked", Callable(self, "_on_chest_unlocked"))

func _on_chest_unlocked():
	print("Skrzynia otwarta, można podnosić!")
	_enable_grab()

func _disable_grab():
	if grab:
		grab.enabled = false

func _enable_grab():
	if grab:
		grab.enabled = true
