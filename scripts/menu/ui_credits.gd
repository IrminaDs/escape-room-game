extends CanvasLayer


@export var element: String

@onready var texts = $Texts

func update_elements():
	for child in texts.get_children():
		child.visible = false
	
	if texts.has_node(element):
		texts.get_node(element).visible = true

func set_element(value: String) -> void:
	element = value
