extends Node

func _ready():
	Room2GameEvents.connect("snapzone_entered", Callable(self, "_on_snapzone_entered"))

func _on_snapzone_entered():
	get_parent().visible=false
	
