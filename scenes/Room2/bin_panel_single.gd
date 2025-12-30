extends CanvasLayer

@onready var label: Label = $Panel/Label1

var state := 0

func _ready():
	_update_label()

func _on_button_up_1_pressed():
	state = 1 - state 
	_update_label()
	
func _update_label():
	label.text = str(state)
