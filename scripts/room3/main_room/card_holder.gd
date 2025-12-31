extends AnimatableBody3D

@onready var snap_zone = $SnapZone
@export var starting_item: Node3D 

func _ready():
	await get_tree().process_frame
	
	if starting_item:
		starting_item.reparent(snap_zone, true)

#func _on_snap_zone_has_picked_up(what):
	#if what:
		#what.reparent(snap_zone, true)
