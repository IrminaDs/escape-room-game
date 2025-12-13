extends Node3D


@onready var contr_left = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController")
@onready var contr_right = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController")

func _ready():
	var player = get_node("/root/Main/Player")
	var point_l = contr_left.get_node("FunctionPointer")
	var point_r = contr_right.get_node("FunctionPointer")
	var move_l = contr_left.get_node("MovementDirect")
	var move_r = contr_right.get_node("MovementTurn")
	var light = player.get_node("SpotLight3D")
	
	point_l.visible = true
	point_r.visible = true
	move_l.enabled = false
	move_r.enabled = false
	light.visible = true
