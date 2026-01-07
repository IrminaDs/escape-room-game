extends CanvasLayer

func _on_b_11_pressed() -> void:
	Room3GameEvents.set_state.emit("base11")

func _on_b_12_pressed() -> void:
	Room3GameEvents.set_state.emit("base12")

func _on_b_21_pressed() -> void:
	Room3GameEvents.set_state.emit("base21")

func _on_b_22_pressed() -> void:
	Room3GameEvents.set_state.emit("base22")
