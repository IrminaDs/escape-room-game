extends Button

func _ready():
	connect("mouse_entered", Callable(self, "_on_enter"))
	connect("mouse_exited", Callable(self, "_on_exit"))

func _on_enter():
	print("ENTER")

func _on_exit():
	print("EXIT")
