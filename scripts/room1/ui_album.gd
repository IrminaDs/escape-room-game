extends CanvasLayer

var photos : Array[Control] = []
var unlocked_photos : Array[int] = [0, 1]
var current_index : int = 0

func _ready():
	photos = [
		$Start,
		$Photo1,
		$Photo2,
		$Photo3,
		$Photo4
	]
	
	_refresh_visibility()

	Room1GameEvents.connect("photo_unlocked", Callable(self, "_on_photo_unlocked"))
	Room1GameEvents.connect("album_left", Callable(self, "_on_album_left"))
	Room1GameEvents.connect("album_right", Callable(self, "_on_album_right"))

func _refresh_visibility():
	for i in range(photos.size()):
		photos[i].visible = false
	
	var active_photo_id = unlocked_photos[current_index]
	photos[active_photo_id].visible = true

func _on_photo_unlocked(photo_id: int):
	if photo_id not in unlocked_photos:
		unlocked_photos.append(photo_id)

	_refresh_visibility()

func _on_album_left():
	if unlocked_photos.size() <= 1:
		return
	current_index = (current_index - 1 + unlocked_photos.size()) % unlocked_photos.size()
	_refresh_visibility()

func _on_album_right():
	if unlocked_photos.size() <= 1:
		return
	current_index = (current_index + 1) % unlocked_photos.size()
	_refresh_visibility()
