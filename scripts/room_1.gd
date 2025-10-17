extends Node3D

@onready var fade_rect = $CanvasLayer/ColorRect

func _ready():
	fade_rect.modulate.a = 1.0  # całkowicie czarny na start
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
