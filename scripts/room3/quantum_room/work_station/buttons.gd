extends CanvasLayer

func _on_a_pressed() -> void:
	Room3GameEvents.next_question.emit("A")

func _on_b_pressed() -> void:
	Room3GameEvents.next_question.emit("B")

func _on_c_pressed() -> void:
	Room3GameEvents.next_question.emit("C")

func _on_d_pressed() -> void:
	Room3GameEvents.next_question.emit("D")
