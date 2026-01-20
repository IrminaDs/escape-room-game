extends CanvasLayer

@onready var send_cubits := $Panel/SendCubits
@onready var intro := $Panel/Intro
@onready var label := $Panel/Intro/Label
@onready var label2 := $Panel/Intro/Label2
@onready var send := $Panel/SendCubits/Send
@onready var transmission := $Panel/Transmission
@onready var anim := $AnimationPlayer
@onready var wire := $Panel/Wire
@onready var safe_connection := $Panel/SafeConnection

var icons := {
	"base11": preload("res://models/room3/icons/base11.png"),
	"base12": preload("res://models/room3/icons/base12.png"),
	"base21": preload("res://models/room3/icons/base21.png"),
	"base22": preload("res://models/room3/icons/base22.png")
}

@onready var slots := [
	$Panel/SendCubits/HBoxContainer/First,
	$Panel/SendCubits/HBoxContainer/Second,
	$Panel/SendCubits/HBoxContainer/Third,
	$Panel/SendCubits/HBoxContainer/Fourth,
	$Panel/SendCubits/HBoxContainer/Fifth,
	$Panel/SendCubits/HBoxContainer2/First,
	$Panel/SendCubits/HBoxContainer2/Second,
	$Panel/SendCubits/HBoxContainer2/Third,
	$Panel/SendCubits/HBoxContainer2/Fourth,
	$Panel/SendCubits/HBoxContainer2/Fifth
]

@onready var bit_labels := [
	$Panel/SendCubits/HBoxContainer/First2,
	$Panel/SendCubits/HBoxContainer/Second2,
	$Panel/SendCubits/HBoxContainer/Third2,
	$Panel/SendCubits/HBoxContainer/Fourth2,
	$Panel/SendCubits/HBoxContainer/Fifth2,
	$Panel/SendCubits/HBoxContainer2/First2,
	$Panel/SendCubits/HBoxContainer2/Second2,
	$Panel/SendCubits/HBoxContainer2/Third2,
	$Panel/SendCubits/HBoxContainer2/Fourth2,
	$Panel/SendCubits/HBoxContainer2/Fifth2
]

var selected_states : Array[String] = []
var n := 0

func _ready() -> void:
	send.disabled = true
	_intro()
	Room3GameEvents.set_state.connect(_on_set_state)

func _intro():
	await get_tree().create_timer(7).timeout
	label.visible = false
	label2.visible = true
	await get_tree().create_timer(7).timeout
	intro.queue_free()
	send_cubits.visible = true

func _on_set_state(state: String) -> void:
	if selected_states.size() >= slots.size():
		return

	var index := selected_states.size()
	selected_states.append(state)
	slots[index].texture = icons[state]

	if selected_states.size() == slots.size():
		send.disabled = false

func _on_send_pressed() -> void:
	send.disabled = true
	send_cubits.visible = false
	transmission.visible = true
	anim.play("Transmission")
	await get_tree().create_timer(4).timeout

	if n == 0 :
		transmission.visible = false
		wire.visible = true
		anim.play("Wire")
		await get_tree().create_timer(5).timeout
		wire.queue_free()
		_reset_send_cubits()
	else:
		transmission.queue_free()
		send_cubits.visible = true
		await _successful_connection()
	n += 1

func _reset_send_cubits():
	selected_states.clear()
	send.disabled = true

	for i in range(slots.size()):
		slots[i].texture = null
		slots[i].visible = true
		bit_labels[i].text = ""
		bit_labels[i].visible = false

	send_cubits.visible = true

func _successful_connection() -> void:
	Room3GameEvents.start_transmission.emit()
	send_cubits.get_node("Label").visible = false
	send_cubits.get_node("Send").visible = false
	Room3GameEvents.transmission_sound.emit()
	anim.play("TransmissionSuccessful")
	await get_tree().create_timer(7).timeout
	anim.play("TransmissionSuccessfulEnd")
	

	var key := await _reveal_bits_sequentially()
	Room3GameEvents.key_generated.emit(key)
	await get_tree().create_timer(1).timeout
	
	send_cubits.queue_free()
	safe_connection.visible = true
	await get_tree().create_timer(1.5).timeout
	safe_connection.get_node("Label2").visible = true
	await get_tree().create_timer(1.5).timeout
	safe_connection.get_node("Label3").text = key
	safe_connection.get_node("Label3").visible = true

func _reveal_bits_sequentially() -> String:
	var key := ""

	for i in range(selected_states.size()):
		await get_tree().create_timer(0.6).timeout

		slots[i].visible = false
		bit_labels[i].visible = true

		if i == 2 or i == 9:
			bit_labels[i].text = "-"
			continue

		var bit := "1"
		if selected_states[i] == "base11" or selected_states[i] == "base21":
			bit = "0"

		bit_labels[i].text = bit
		key += bit

	return key
