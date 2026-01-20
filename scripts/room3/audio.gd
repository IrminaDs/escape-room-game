extends Node

@onready var music := $Music
@onready var sfx := $SFX
@onready var ui := $UI
@onready var final := $FinalMessage

@onready var alarm = preload("res://models/room3/sounds/alarm.mp3")
@onready var notification_stream = preload("res://models/room3/sounds/notification.mp3")
@onready var background_music = preload("res://models/room3/sounds/mixkit-piano-reflections-22.mp3")
@onready var correct = preload("res://models/room3/sounds/correct.mp3")
@onready var wrong = preload("res://models/room3/sounds/wrong.mp3")
@onready var final_message = preload("res://models/room3/sounds/final_message.mp3")
@onready var transmission = preload("res://models/room3/sounds/mixkit-sci-fi-high-tech-sounds-860.wav")


func _ready():
	Room3GameEvents.show_screen.connect(_new_message)
	
	Room3GameEvents.glitch.connect(_on_glitch)
	
	Room3GameEvents.answer_correct.connect(_on_answer_correct)
	Room3GameEvents.answer_wrong.connect(_on_answer_wrong)
	
	Room3GameEvents.correct_key.connect(_on_answer_correct)
	Room3GameEvents.wrong_key.connect(_on_answer_wrong)
	
	Room3GameEvents.stop_music.connect(_on_stop_music)
	Room3GameEvents.start_music.connect(_on_start_music)
	
	Room3GameEvents.correct_key.connect(_final_message)
	
	Room3GameEvents.transmission_sound.connect(_transmission_sound)
	

	
func _on_start_music():
	music.stream = background_music
	music.volume_db = -18
	music.pitch_scale = 0.9
	music.play()

func _on_stop_music():
	music.stop()

func _new_message(screen_id: String):
	if screen_id in ["first_message", "second_message", "last_message", "door_schema", "last_screen"]:
		ui.stream = notification_stream
		ui.play()

func _on_glitch():
	sfx.stream = alarm
	sfx.play()
	await get_tree().create_timer(12).timeout
	sfx.stop()
	
func _on_answer_correct():
	ui.stream = correct
	ui.play()
	
func _on_answer_wrong():
	ui.stream = wrong
	ui.play()

func _final_message():
	final.stream = final_message
	final.play()
	
func _transmission_sound():
	sfx.stream = transmission
	sfx.volume_db = -18
	sfx.play()
	await get_tree().create_timer(9).timeout
	sfx.stop()
