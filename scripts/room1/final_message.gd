extends AudioStreamPlayer3D


func _ready():
	Room1GameEvents.connect("final", Callable(self, "_on_final"))

func _on_final():
	var stream = load("res://models/Room1/sounds/173262__toam__scificlass-short-single.ogg")
	self.stream = stream
	self.play()
	
	await self.finished
	stream = load("res://models/Room1/sounds/final_message.ogg")
	self.stream = stream
	self.play()
