extends CanvasLayer

@export var correct_code := "BBBBBBB"
var current_code := ["A","A","A","A","A","A","A"]
var letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var code_unlocked := false

var selected_letter := 0  # aktualnie podświetlana litera
var player_node : CharacterBody3D = null  # referencja do gracza
var desk_node : Node3D = null  # referencja do biurka

func _ready():
	_update_display()
	_highlight_selected()

func _process(delta):
	if not player_node or code_unlocked:
		return

	# zmiana liter strzałkami
	if Input.is_action_just_pressed("move_up"):
		change_letter(selected_letter, 1)
	elif Input.is_action_just_pressed("move_down"):
		change_letter(selected_letter, -1)
	elif Input.is_action_just_pressed("move_right"):
		selected_letter = (selected_letter + 1) % 7
		_highlight_selected()
	elif Input.is_action_just_pressed("move_left"):
		selected_letter = (selected_letter - 1 + 7) % 7
		_highlight_selected()

	# Escape do zamknięcia UI
	if Input.is_action_just_pressed("cancel"):
		_close_ui()

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
	$Panel/Label5.text = current_code[4]
	$Panel/Label6.text = current_code[5]
	$Panel/Label7.text = current_code[6]

func _highlight_selected():
	for i in range(7):
		var label = $Panel.get_node("Label%d" % (i+1))
		if i == selected_letter:
			label.modulate = Color(0.9, 0.4, 0.1)
		else:
			label.modulate = Color(1, 1, 1)

func _check_code():
	if "".join(current_code) == correct_code:
		code_unlocked = true
		await _flash_colors()
		
		if desk_node:
			var anim_player = desk_node.get_node("StaticBody3D/Sketchfab_Scene/AnimationPlayer")
			if anim_player:
				anim_player.play("Open")
				
		var lock_area = desk_node.get_node("InteractionZone")
		if lock_area:
			lock_area.queue_free()
		
		_close_ui()


func _flash_colors():
	for i in range(2):
		_set_letters_color(Color(0.9, 0.4, 0.1))
		await get_tree().create_timer(0.5).timeout
		_set_letters_color(Color(1, 1, 1))
		await get_tree().create_timer(0.3).timeout
	_set_letters_color(Color(0.9, 0.4, 0.1))
	await get_tree().create_timer(0.5).timeout


func _set_letters_color(color: Color):
	for i in range(7):
		var label = $Panel.get_node("Label%d" % (i+1))
		label.modulate = color


func _close_ui():
	if player_node:
		player_node.set("can_move", true)
		
	# zapisz kod w desk_node
	if desk_node:
		desk_node.set_meta("saved_code", current_code.duplicate())

	queue_free()

# Wywołaj to zaraz po dodaniu UI, aby zablokować ruch gracza
func setup_ui_for_player(player: CharacterBody3D, desk: Node3D):
	player_node = player
	player_node.set("can_move", false)
	desk_node = desk
	
	if desk_node.has_meta("saved_code"):
		current_code = desk_node.get_meta("saved_code")
		_update_display()
		_highlight_selected()
