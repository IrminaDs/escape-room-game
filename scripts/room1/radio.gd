extends Node3D


@onready var sfx_player = $SfxPlayer
@onready var music_player = $MusicPlayer

var radio_on = false

func _ready():
	var stream = load("res://models/Room1/sounds/Canon in D for Two Harps.mp3")
	stream.loop = true
	music_player.stream = stream
	toggle_radio()

func toggle_radio():
	sfx_player.play()

	if not radio_on:
		await sfx_player.finished
		await get_tree().create_timer(1).timeout
		music_player.play()
		radio_on = true
	else:
		music_player.stop()
		radio_on = false
