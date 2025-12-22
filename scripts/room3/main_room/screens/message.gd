extends CanvasLayer

@onready var notification_message: Label = $Panel/Notification
@onready var message: Panel = $Panel/Message

func _ready() -> void:
	_hide_notification()
	

func _hide_notification():
	await get_tree().create_timer(2.5).timeout
	notification_message.visible = false
	_show_message()

func _show_message():
	message.visible = true
