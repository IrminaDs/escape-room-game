extends Node3D


func _ready() -> void:
	var ui1 = $Menu.get_node("Viewport").get_child(0)
	ui1.set_element("Menu")
	ui1.update_elements()
	
	var ui2 = $Room1.get_node("Viewport").get_child(0)
	ui2.set_element("Room1")
	ui2.update_elements()
	
	var ui3 = $Room2.get_node("Viewport").get_child(0)
	ui3.set_element("Room2")
	ui3.update_elements()
	
	var ui4 = $Room3.get_node("Viewport").get_child(0)
	ui4.set_element("Room3")
	ui4.update_elements()
