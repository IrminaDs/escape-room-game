extends CanvasLayer

@export var correct_code := "OPEN"
var current_code := ["A","A","A","A"]
var letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

var selected_letter := 0  # aktualnie podświetlana litera
var player_node : CharacterBody3D = null  # referencja do gracza
var chest_node : Node3D = null  # referencja do skrzyni

func _ready():
	_update_display()
	_highlight_selected()

func _process(delta):
	if not player_node:
		return

	# zmiana liter strzałkami
	if Input.is_action_just_pressed("move_up"):
		change_letter(selected_letter, 1)
	elif Input.is_action_just_pressed("move_down"):
		change_letter(selected_letter, -1)
	elif Input.is_action_just_pressed("move_right"):
		selected_letter = (selected_letter + 1) % 4
		_highlight_selected()
	elif Input.is_action_just_pressed("move_left"):
		selected_letter = (selected_letter - 1 + 4) % 4
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

func _highlight_selected():
	for i in range(4):
		var label = $Panel.get_node("Label%d" % (i+1))
		if i == selected_letter:
			label.modulate = Color(0.1, 0.4, 0.7)  # żółty
		else:
			label.modulate = Color(1, 1, 1)  # biały

func _check_code():
	if "".join(current_code) == correct_code:
		if chest_node:
			var anim_player = chest_node.get_node("Chest3D/Sketchfab_Scene/AnimationPlayer")
			if anim_player:
				anim_player.play("Armature|A_Open")
				
			# Usuń Area3D z zamkiem, żeby nie dało się już wchodzić
		var lock_area = chest_node.get_node("Lock3D")  # podaj dokładną ścieżkę do Area3D
		if lock_area:
			lock_area.queue_free()
			
		_close_ui()

func _close_ui():
	if player_node:
		player_node.set("can_move", true)
	queue_free()

# Wywołaj to zaraz po dodaniu UI, aby zablokować ruch gracza
func setup_ui_for_player(player: CharacterBody3D, chest: Node3D):
	player_node = player
	player_node.set("can_move", false)
	chest_node = chest
