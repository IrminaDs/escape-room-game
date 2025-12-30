extends CanvasLayer

@export var correct_code := "21"
@export var color: Color
@export var signal_to_emit: String

var current_code := ["1","2"]
var letters := "1234567890"
var code_unlocked := false
var selected_letter := 0

func _ready():
	_update_display()
	#_highlight_selected()

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
	$Label1.text = current_code[0]
	$Label2.text = current_code[1]

#func _highlight_selected():
	#for i in range(2):
		#var label = $Panel.get_node("Label%d" % (i+1))
		#if i == selected_letter:
			#label.modulate = color
		#else:
			#label.modulate = Color(1, 1, 1)

func _check_code():
	if "".join(current_code) == correct_code:
		code_unlocked = true
		await _flash_letters()
		Room2GameEvents.emit_signal(signal_to_emit)

func _flash_letters():
	for i in range(2):
		_set_letters_color(color)
		await get_tree().create_timer(0.5).timeout
		_set_letters_color(Color(1, 1, 1))
		await get_tree().create_timer(0.3).timeout
	_set_letters_color(color)
	await get_tree().create_timer(0.5).timeout


func _set_letters_color(color: Color):
	for i in range(2):
		var label = $Panel.get_node("Label%d" % (i+1))
		label.modulate = color


func _on_button_up_1_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 0
#	_highlight_selected()
	change_letter(0, 1)


func _on_button_up_2_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 1
#	_highlight_selected()
	change_letter(1, 1)


func _on_button_down_1_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 0
#	_highlight_selected()
	change_letter(0, -1)


func _on_button_down_2_pressed() -> void:
	if code_unlocked:
		return
	selected_letter = 1
#	_highlight_selected()
	change_letter(1, -1)
