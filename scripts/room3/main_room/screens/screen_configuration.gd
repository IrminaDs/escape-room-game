extends CanvasLayer

@export var keyboard: Node3D

@onready var menu_button := $ConfigurationOption/VBoxContainer/MenuButton
@onready var root_panel := $ConfigurationOption
@onready var select_screen := $ConfigurationOption/VBoxContainer
@onready var message := $ConfigurationOption/Message
@onready var config_panel := $ConfigurationOption/PanelConfiguration
@onready var title_label := $ConfigurationOption/PanelConfiguration/VBoxContainer/Title
@onready var button_back := $ConfigurationOption/PanelConfiguration/VBoxContainer/BackNextButtons/ButtonBack
@onready var button_next := $ConfigurationOption/PanelConfiguration/VBoxContainer/BackNextButtons/ButtonNext
@onready var year := $ConfigurationOption/PanelConfiguration/VBoxContainer/Year/LineEdit
@onready var key_length := $ConfigurationOption/PanelConfiguration/VBoxContainer/KeyLength/LineEdit
@onready var type := $ConfigurationOption/PanelConfiguration/VBoxContainer/Type/OptionButton

func _ready():
	_show_element(select_screen)
	
	year.focus_entered.connect(_on_focus_entered)
	year.focus_exited.connect(_on_focus_exited)
	
	key_length.focus_entered.connect(_on_focus_entered)
	key_length.focus_exited.connect(_on_focus_exited)
	
	menu_button.algorithm_selected.connect(_on_algorithm_selected)
	
	button_back.pressed.connect(_on_back_pressed)
	button_next.pressed.connect(_on_next_pressed)

func _on_algorithm_selected(selected: String) -> void:
	_show_element(config_panel)
	title_label.text = selected
	
func _on_back_pressed() -> void:
	_show_element(select_screen)
	_clear_input_fields()
	
func _on_next_pressed() -> void:
	if _check_if_correct():
		Room3GameEvents.emit_signal("answer_correct")

	else: 
		Room3GameEvents.emit_signal("answer_wrong")
		_clear_input_fields()
		_show_element(message)
		await get_tree().create_timer(3).timeout
		_show_element(select_screen)
	
func _show_element(element_to_show: Control) -> void:
	var all_elements = [select_screen, config_panel, message]
	for el in all_elements:
		el.visible = (el == element_to_show)
	
func _clear_input_fields() -> void:
	year.text = ""
	key_length.text = ""
	type.selected = -1
	
func _check_if_correct() -> bool:
	var selected_algorithm = title_label.text
	var key_length_value = key_length.text
	var year_value = year.text
	var algorithm_type_index = type.selected
	
	var correct_algorithm = "AES"
	var correct_key_lengths = ["128", "192", "256"]
	var correct_year = ["1998", "2001"]
	var correct_type_index = 1
	
	return selected_algorithm == correct_algorithm \
		and key_length_value in correct_key_lengths \
		and year_value in correct_year \
		and algorithm_type_index == correct_type_index
		
func _on_focus_entered():
	Room3GameEvents.emit_signal("show_keyboard", year)
	Room3GameEvents.emit_signal("show_keyboard", key_length)

func _on_focus_exited():
	Room3GameEvents.emit_signal("hide_keyboard")
