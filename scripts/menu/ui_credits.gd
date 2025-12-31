extends CanvasLayer


@export var element: String

@onready var texts = $Texts

func _ready() -> void:
	for child in texts.get_children():
		child.visible = false
	
	if texts.has_node(element):
		texts.get_node(element).visible = true
