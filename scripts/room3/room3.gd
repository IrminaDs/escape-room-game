extends Node3D


@onready var contr_left = get_tree().get_current_scene().get_node("Player/XROrigin3D/LeftController")
@onready var contr_right = get_tree().get_current_scene().get_node("Player/XROrigin3D/RightController")

@onready var point_l = contr_left.get_node("FunctionPointer")
@onready var point_r = contr_right.get_node("FunctionPointer")
@onready var move_l  = contr_left.get_node("MovementDirect")
@onready var move_r  = contr_right.get_node("MovementTurn")
@onready var light   = get_tree().get_current_scene().get_node("Player/SpotLight3D")


func _ready():
	Room3GameEvents.lock_player.connect(_lock_movement)
	Room3GameEvents.unlock_player.connect(_unlock_movement)
	_apply_state()

func _apply_state():
	point_l.visible = true
	point_r.visible = true
	move_l.enabled = false
	move_r.enabled = false
	light.visible = false
	
func _lock_movement():
	move_l.enabled = false
	move_r.enabled = false

func _unlock_movement():
	move_l.enabled = true
	move_r.enabled = true
	
