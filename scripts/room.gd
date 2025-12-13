extends Node3D


@onready var contr_left = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController")
@onready var contr_right = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController")

func _ready():
	var point_l = contr_left.get_node("FunctionPointer")
	var point_r = contr_right.get_node("FunctionPointer")
	var move_l = contr_left.get_node("MovementDirect")
	var move_r = contr_right.get_node("MovementTurn")
	var light = get_tree().get_current_scene().get_node("Player/SpotLight3D")
	
	point_l.visible = false
	point_r.visible = false
	move_l.enabled = true
	move_r.enabled = true
	light.visible = false
