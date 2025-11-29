extends StaticBody3D

@onready var mesh_nor: MeshInstance3D = $CSGBakedMeshInstance3D
@onready var mesh_hole: MeshInstance3D = $MeshWithHole
@onready var coll_nor: CollisionShape3D = $CSGBakedCollisionShape3D

func _ready() -> void:
	coll_nor.disabled = true
	mesh_hole.visible = false
	mesh_nor.visible = true
	
	Room1GameEvents.connect("clock_lock", Callable(self, "_on_clock_lock"))

func _on_clock_lock():
	mesh_hole.visible = true
	mesh_nor.visible = false
