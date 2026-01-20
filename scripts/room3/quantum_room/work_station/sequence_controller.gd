extends Node

@onready var viewport1: XRToolsViewport2DIn3D = get_parent().get_node("Viewport2Din3D")
@onready var viewport2: XRToolsViewport2DIn3D = get_parent().get_node("Viewport2Din3D/Buttons")
@onready var viewport3: XRToolsViewport2DIn3D = get_parent().get_node("BaseBit")

var QUIZ = preload("res://scenes/room3/quantum_room/work_station/ui_quiz.tscn")
var LAST_TASK = preload("res://scenes/room3/quantum_room/work_station/ui_last_task.tscn")
var SEND = preload("res://scenes/room3/quantum_room/work_station/ui_send.tscn")

func _ready():
	Room3GameEvents.start_quiz.connect(_on_start_quiz)
	Room3GameEvents.quiz_completed.connect(_on_quiz_completed)
	Room3GameEvents.start_transmission.connect(_on_start_transmission)
	
func _on_start_quiz():
	viewport1.scene = QUIZ
	
	viewport2.visible = true
	
func _on_quiz_completed():
	viewport1.scene = LAST_TASK
	viewport2.queue_free()
	await get_tree().create_timer(14).timeout
	viewport3.visible = true
	
func _on_start_transmission():
	viewport3.queue_free()
	
