extends MenuButton

signal algorithm_selected(selected: String)

func _ready():
	var popup := get_popup()
	popup.clear()

	var algorithms := [
		"                                                                 IDEA",
		"                                                                  RSA",
		"                                                                  AES",
		"                                                             BLOWFISH",
		"                                                                  DES",
		"                                                             CAMELLIA"
	]

	for alg in algorithms:
		popup.add_item(alg)

	popup.id_pressed.connect(_on_item_selected)
	_apply_style(popup)


func _on_item_selected(id: int) -> void:
	var selected := get_popup().get_item_text(id).strip_edges()
	emit_signal("algorithm_selected", selected)


func _apply_style(popup: PopupMenu) -> void:
	var theme := Theme.new()
	theme.set_color("font_color", "PopupMenu", Color(0.396, 1.0, 1.0))
	theme.set_color("font_hover_color", "PopupMenu", Color(0.573, 0.855, 0.855))
	theme.set_color("font_disabled_color", "PopupMenu", Color(0.537, 0.537, 0.537))

	var empty_style := StyleBoxEmpty.new()
	theme.set_stylebox("panel", "PopupMenu", empty_style)
	theme.set_stylebox("hover", "PopupMenu", empty_style)
	theme.set_stylebox("pressed", "PopupMenu", empty_style)
	theme.set_stylebox("focus", "PopupMenu", empty_style)
	popup.theme = theme
