extends CanvasLayer

@export var correct_code := "BBBB"
var current_code := ["A","A","A","A"]
var letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var code_unlocked := false
var selected_letter := 0

func _ready():
	_update_display()
	_highlight_selected()

func _process(delta):
	if code_unlocked:
		return

func change_letter(index: int, step: int):
	var i = letters.find(current_code[index])
	i = (i + step) % letters.length()
	current_code[index] = letters[i]
	_update_display()
	_check_code()

func _update_display():
	$Panel/Label1.text = current_code[0]
	$Panel/Label2.text = current_code[1]
	$Panel/Label3.text = current_code[2]
	$Panel/Label4.text = current_code[3]

func _highlight_selected():
	for i in range(4):
		var label = $Panel.get_node("Label%d" % (i+1))
		if i == selected_letter:
			label.modulate = Color(0.1, 0.4, 0.7)
		else:
			label.modulate = Color(1, 1, 1)  # biały

func _check_code():
	if "".join(current_code) == correct_code:
		code_unlocked = true
		await _flash_letters()
		Room1GameEvents.emit_signal("chest_unlocked")

func _flash_letters():
	for i in range(2):
		_set_letters_color(Color(0.1, 0.4, 0.7))
		await get_tree().create_timer(0.5).timeout
		_set_letters_color(Color(1, 1, 1))
		await get_tree().create_timer(0.3).timeout
	_set_letters_color(Color(0.1, 0.4, 0.7))
	await get_tree().create_timer(0.5).timeout


func _set_letters_color(color: Color):
	for i in range(4):
		var label = $Panel.get_node("Label%d" % (i+1))
		label.modulate = color


func _on_button_up_1_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 0
	_highlight_selected()
	change_letter(0, 1)


func _on_button_up_2_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 1
	_highlight_selected()
	change_letter(1, 1)


func _on_button_up_3_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 2
	_highlight_selected()
	change_letter(2, 1)


func _on_button_up_4_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 3
	_highlight_selected()
	change_letter(3, 1)


func _on_button_down_1_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 0
	_highlight_selected()
	change_letter(0, -1)


func _on_button_down_2_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 1
	_highlight_selected()
	change_letter(1, -1)


func _on_button_down_3_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 2
	_highlight_selected()
	change_letter(2, -1)


func _on_button_down_4_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 3
	_highlight_selected()
	change_letter(3, -1)
