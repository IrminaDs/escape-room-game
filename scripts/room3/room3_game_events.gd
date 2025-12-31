extends Node

var room_finished := false

# first stage
signal modern_shelf_unlocked
signal drawer_2_unlocked

signal show_keyboard(target: Node)
signal hide_keyboard

signal glitch
signal glitch_finished

signal lock_player
signal unlock_player

signal show_screen(screen_id: String)

# audio
signal play_background_music
signal start_music
signal stop_music
signal transmission_sound


# configuration
signal answer_wrong
signal answer_correct

signal correct_schema


# work station | second stage
signal start_quiz
signal next_question(letter: String)
signal quiz_completed

# last key
signal correct_key
signal wrong_key

# send photons
signal set_state(state: String)
signal start_transmission

# AES key
signal key_generated(key: String)
