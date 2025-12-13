extends Node3D

@onready var player_body = $XROrigin3D/PlayerBody
@onready var footstep_audio = $FootstepAudio

var step_interval = 0.45
var step_timer = 0.0

func _process(delta):
	var speed = player_body.ground_control_velocity.length()

	if speed > 0.2:    # próg ruchu, dopasuj
		step_timer -= delta
		if step_timer <= 0:
			footstep_audio.play()
			step_timer = step_interval
	else:
		step_timer = 0.0
