extends Node

@onready var music := $Music
@onready var sfx := $SFX
@onready var ui := $UI

@onready var alarm = preload("res://models/room3/sounds/alarm.mp3")
@onready var notification_stream = preload("res://models/room3/sounds/notification.mp3")
@onready var background_music = preload("res://models/room3/sounds/mixkit-piano-reflections-22.mp3")
@onready var correct = preload("res://models/room3/sounds/correct.mp3")
@onready var wrong = preload("res://models/room3/sounds/wrong.mp3")


func _ready():
	Room3GameEvents.lock_player.connect(_on_intro_start)
	Room3GameEvents.show_screen.connect(_new_message)
	Room3GameEvents.glitch.connect(_on_glitch)
	Room3GameEvents.answer_correct.connect(_on_answer_correct)
	Room3GameEvents.answer_wrong.connect(_on_answer_wrong)

	
func _on_intro_start():
	music.stream = background_music
	music.volume_db = -18
	music.pitch_scale = 0.9
	music.play()

func _new_message(screen_id: String):
	if screen_id in ["first_message", "second_message", "last_message", "door_schema"]:
		ui.stream = notification_stream
		ui.play()

func _on_glitch():
	sfx.stream = alarm
	sfx.play()
	
func _on_answer_correct():
	ui.stream = correct
	ui.play()
	
func _on_answer_wrong():
	ui.stream = wrong
	ui.play()
