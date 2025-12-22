extends Node

enum State {
	INTRO_LOCKED,
	SECOND_MESSAGE,
	GLITCH,
	CONFIGURATION,
	LAST_MESSAGE,
	DOOR_SCHEMA,
	LAST_SCREEN
}

var state: State

func _ready():
	_set_state(State.INTRO_LOCKED)
	Room3GameEvents.answer_correct.connect(_on_answer_correct)

func _set_state(new_state: State) -> void:
	state = new_state

	match state:
		State.INTRO_LOCKED:
			_enter_intro_locked()

		State.GLITCH:
			_enter_glitch()
			
		State.SECOND_MESSAGE:
			_enter_second_message()

		State.CONFIGURATION:
			_enter_configuration()

		State.LAST_MESSAGE:
			_enter_last_message()

		State.DOOR_SCHEMA:
			_enter_door_schema()
		
		State.LAST_SCREEN:
			_enter_last_screen()
			
			
func _enter_intro_locked():
	await get_tree().create_timer(12).timeout
	_set_state(State.GLITCH)
	
func _enter_glitch():
	Room3GameEvents.emit_signal("glitch")
	await get_tree().create_timer(11).timeout
	Room3GameEvents.emit_signal("glitch_finished")
	_set_state(State.SECOND_MESSAGE)
	
func _enter_second_message():
	Room3GameEvents.emit_signal("show_screen", "second_message")
	Room3GameEvents.emit_signal("unlock_player")
	await get_tree().create_timer(40).timeout
	_set_state(State.CONFIGURATION)
	
func _enter_configuration():
	Room3GameEvents.emit_signal("show_screen", "configuration_screen")
	
func _on_answer_correct():
	_set_state(State.LAST_MESSAGE)
	
func _enter_last_message():
	Room3GameEvents.emit_signal("show_screen", "last_message")
	await get_tree().create_timer(35).timeout
	_set_state(State.DOOR_SCHEMA)

func _enter_door_schema():
	Room3GameEvents.emit_signal("show_screen", "door_schema")
	
func _enter_last_screen():
	Room3GameEvents.emit_signal("show_screen", "last_screen")
