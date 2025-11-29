extends StaticBody3D


@onready var lock_area: Node3D = $InteractionZone
@onready var viewport: Node3D = $Viewport2Din3D

func _ready():
	self.visible = false
	lock_area.monitoring = false
	
	Room1GameEvents.connect("ceasar_placed", Callable(self, "_on_ceasar_placed"))
	Room1GameEvents.connect("clock_lock", Callable(self, "_on_clock_lock"))

func _on_ceasar_placed():
	self.visible = true
	lock_area.monitoring = true

func _on_clock_lock():
	if lock_area:
		lock_area.queue_free()
	if viewport:
		viewport.queue_free()
