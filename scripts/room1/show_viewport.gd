extends Node

@onready var parent_pickable = get_parent()

func _ready():
	$"../Viewport2Din3D".visible = false
	
	if parent_pickable.has_signal("grabbed"):
		parent_pickable.connect("grabbed", Callable(self, "_on_grabbed"))
		
	if parent_pickable.has_signal("released"):
		parent_pickable.connect("released", Callable(self, "_on_released"))

func _on_grabbed(pickable, by):
	if pickable == get_parent():
		$"../Viewport2Din3D".visible = true

func _on_released(pickable, by):
	if pickable == get_parent():
		$"../Viewport2Din3D".visible = false
