extends Node2D

@export var allow_crossed_wires = true
@export var only_cardinals = false
@export var has_setup = true

@onready var left_controller: XRController3D = get_node("/root/Main/Player/XROrigin3D/LeftController")
@onready var right_controller: XRController3D = get_node("/root/Main/Player/XROrigin3D/RightController")

const Circle = preload("res://scenes/room3/main_room/wire_connection/circle.gd")

var circles: Array[Circle] = []
var correct_sequence = Line2D.new()
var is_correct = false
var correct_color = null

var spacing = 150
var radius = 36
var side_offset = 100
var currently_selected = null
var default_color = Color.CYAN

var main_line = Line2D.new()

var good_line_color = Color.BLACK
var bad_line_color = Color.RED
var most_recent_color = Color.BLACK

var solved_color = Color.GREEN

var reset_circle: Circle

func _ready() -> void:
	add_child(main_line)
	for y in range(3):
		for x in range(3):
			circles.append(Circle.new(
				Vector2(x*spacing+side_offset, y*spacing+side_offset), 
				radius, default_color))
	
	for i in [0, 1, 4, 2, 5, 8, 7, 3, 6]:
		correct_sequence.add_point(circles[i].pos)
	
	reset_circle = Circle.new(Vector2(spacing+side_offset, 3*spacing+side_offset), radius, Color.ROYAL_BLUE)
	circles.append(reset_circle)
	
	var reset_label := Label.new()
	reset_label.text = "R"
	
	var label_settings := LabelSettings.new()
	label_settings.font = load("res://models/room3/fonts/Science_Gothic/static/ScienceGothic_SemiCondensed-Light.ttf")
	label_settings.font_size = 32
	
	reset_label.label_settings = label_settings
	
	reset_label.size = reset_label.get_minimum_size()
	reset_label.position = reset_circle.pos - reset_label.size / 2
	add_child(reset_label)

func _process(delta: float) -> void:
	var left_pressed = left_controller.is_button_pressed("trigger")
	var right_pressed = right_controller.is_button_pressed("trigger")
	if left_pressed or right_pressed:
		return _trigger()
	if not is_correct and main_line.points == correct_sequence.points:
		_on_solved()

func is_connection_valid(start: Vector2, end: Vector2) -> bool:
	if not allow_crossed_wires:
		var bad = false
		for i in range(main_line.points.size()-1):
			if Geometry2D.segment_intersects_segment(
				main_line.get_point_position(i), 
				main_line.get_point_position(i+1),
				start, end
			) != null and main_line.get_point_position(i+1) != start:
				bad = true
				break
		if bad:
			return false
	
	if only_cardinals and not (start.x == end.x or start.y == end.y):
		return false
	
	for circle in circles:
		if circle.pos == start or circle.pos == end:
			continue
		if main_line.points.has(end):
			return false
		if Geometry2D.segment_intersects_circle(start, end, circle.pos, circle.radius) >= 0:
			return false
	return true

func _trigger() -> void:
	var pointer_pos = get_local_mouse_position()

	for circle in circles:
		if Geometry2D.is_point_in_circle(pointer_pos, circle.pos, circle.radius):
			if circle == reset_circle:
				_reset_wires()
				return
			if currently_selected != null:
				currently_selected.color = default_color
			if currently_selected == null or is_connection_valid(currently_selected.pos, circle.pos):
				main_line.add_point(circle.pos)
				currently_selected = circle
				circle.color = Color.MAGENTA
				queue_redraw()

func _reset_wires():
	main_line.clear_points()
	currently_selected = null
	is_correct = false
	for circle in circles:
		if circle != reset_circle:
			circle.color = default_color
	queue_redraw()

func blink_color():
	for i in range(10):
		correct_color = solved_color
		queue_redraw()
		await get_tree().create_timer(.6).timeout
		
		correct_color = null
		queue_redraw()
		await get_tree().create_timer(.6).timeout

func _draw() -> void:
	for circle in circles:
		if circle == reset_circle:
			draw_circle(reset_circle.pos, reset_circle.radius, reset_circle.color)
		else:
			var color_to_draw = correct_color if correct_color != null else circle.color
			draw_circle(circle.pos, circle.radius, color_to_draw)
			
func _on_solved():
	is_correct = true
	blink_color()
	await get_tree().create_timer(2).timeout
	Room3GameEvents.emit_signal("correct_schema")
