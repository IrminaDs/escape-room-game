extends CanvasLayer


func _on_button_1_pressed() -> void:
	get_node("/root/Main").load_scene("res://scenes/Menu/Menu.tscn")

func _on_button_2_pressed() -> void:
	Room1GameEvents.emit_signal("close_exit")
