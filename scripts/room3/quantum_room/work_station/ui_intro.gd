extends CanvasLayer

func _on_button_pressed() -> void:
	Room3GameEvents.start_quiz.emit()
