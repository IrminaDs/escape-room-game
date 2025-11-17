extends CanvasLayer


@export var path: String
var rect: TextureRect

func _ready() -> void:
	rect = $TextureRect
	var image = load(path)
	if image:
		rect.texture = image
