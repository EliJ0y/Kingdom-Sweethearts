extends Node

var resolution_index: int = 2
var window_mode_index: int = 1

var master_volume: int = 10
var music_volume: int = 10
var sound_volume: int = 10

var resolutions: Array[Vector2i] = [
	Vector2i(3840, 2160),
	Vector2i(2560, 1440),
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1280, 720)
	]

var window_modes: Array[String] = [
	"Borderless", "Fullscreen", "Windowed"
	]

func _ready() -> void:
	apply_resolution()
	apply_window_mode()
	apply_master_volume()
	apply_music_volume()
	apply_sound_volume()

func apply_resolution():
	DisplayServer.window_set_size(resolutions[resolution_index])

func change_resolution(direction: int):
	resolution_index = wrapi(resolution_index + direction, 0, resolutions.size())
	apply_resolution()

func get_resolution_text() -> String:
	var res = resolutions[resolution_index]
	return "%dx%d" % [res.x, res.y]


func apply_window_mode():
	match window_modes[window_mode_index]:
		"Borderless": 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		"Fullscreen": 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		"Windowed":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)

func change_window_mode(direction: int):
	window_mode_index = wrapi(window_mode_index + direction, 0, window_modes.size())
	apply_window_mode()

func get_window_mode_text() -> String:
	return window_modes[window_mode_index]


func set_bus_volume(bus_name: String, ui_value: int):
	var bus_index = AudioServer.get_bus_index(bus_name)
	if ui_value == 0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(ui_value))

func change_master_volume(direction: int):
	master_volume = clampi(master_volume + direction, 0, 10)
	apply_master_volume()

func apply_master_volume():
	set_bus_volume("Master", master_volume)

func change_music_volume(direction: int):
	music_volume = clampi(music_volume + direction, 0, 10)
	apply_music_volume()

func apply_music_volume():
	set_bus_volume("Music", sound_volume)

func change_sound_volume(direction: int):
	sound_volume = clampi(sound_volume + direction, 0, 10)
	apply_sound_volume()

func apply_sound_volume():
	set_bus_volume("Sound", sound_volume)
