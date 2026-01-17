extends CanvasLayer


@export var path: String
var rect: TextureRect

func _update_texture():
	rect = $TextureRect
	var image = load(path)
	if image:
		rect.texture = image

func _set_texture(value: String) -> void:
	path = value
