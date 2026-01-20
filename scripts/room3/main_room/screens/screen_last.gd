extends CanvasLayer

@export var keyboard: Node3D

@onready var key := $Panel/KeyPanel/VBoxContainer/Key
@onready var button_next := $Panel/KeyPanel/VBoxContainer/NextButton/ButtonNext
@onready var key_panel := $Panel/KeyPanel
@onready var message := $Panel/Message
@onready var message2 := $Panel/Message2

var correct_key := ""
var key_unlocked := false

func _ready() -> void:
	Room3GameEvents.key_generated.connect(_on_key_generated)

func _on_key_generated(generated_key: String) -> void:
	correct_key = generated_key
	key_unlocked = true

func _on_focus_entered():
	Room3GameEvents.emit_signal("show_keyboard", key)

func _on_focus_exited():
	Room3GameEvents.hide_keyboard.emit()

func _on_next_pressed() -> void:
	if not key_unlocked:
		Room3GameEvents.wrong_key.emit()
		_clear_input_field()
		_show_element(message)
		await get_tree().create_timer(3).timeout
		_show_element(key_panel)
		return
	
	if _check_if_correct():
		Room3GameEvents.correct_key.emit()
		key_panel.queue_free()
		message2.visible = true
		Room3GameEvents.room_finished = true


	else: 
		Room3GameEvents.wrong_key.emit()
		_clear_input_field()
		_show_element(message)
		await get_tree().create_timer(3).timeout
		_show_element(key_panel)

func _show_element(element_to_show: Control) -> void:
	for el in [key_panel, message]:
		el.visible = (el == element_to_show)

func _check_if_correct() -> bool:
	return key.text == correct_key
	
func _clear_input_field() -> void:
	key.text = ""
