extends Node2D

var is_open = false
var graphics_settings_open = false
var audio_settings_open = false


func _ready() -> void:
	update_text()

func update_text():
	$"Control/Graphics Settings/Resolution Settings/Resolution Text".text = Settings.get_resolution_text()
	$"Control/Graphics Settings/Window Mode Settings/Window Mode Text".text = Settings.get_window_mode_text()
	$"Control/Audio Settings/Master Volume Settings/Master Integer".text = str(Settings.master_volume)
	$"Control/Audio Settings/Music Volume Settings/Music Integer".text = str(Settings.music_volume)
	$"Control/Audio Settings/Sound Volume Settings/Sound Integer".text = str(Settings.sound_volume)
	
func _on_back_pressed() -> void:
	hide()


func _on_graphics_pressed() -> void:
	if !graphics_settings_open:
		graphics_settings_open = true
		audio_settings_open = false
		$"Control/Graphics Settings".visible = true
		$"Control/Audio Settings".visible = false
	elif audio_settings_open:
		graphics_settings_open = true
		audio_settings_open = false
		$"Control/Graphics Settings".visible = true
		$"Control/Audio Settings".visible = false
	else:
		graphics_settings_open = false
		$"Control/Graphics Settings".visible = false

func _on_resolution_arrow_left_pressed() -> void:
	Settings.change_resolution(-1)
	update_text()

func _on_resolution_arrow_right_pressed() -> void:
	Settings.change_resolution(1)
	update_text()

func _on_window_mode_arrow_left_pressed() -> void:
	Settings.change_window_mode(-1)
	update_text()

func _on_window_mode_arrow_right_pressed() -> void:
	Settings.change_window_mode(1)
	update_text()


func _on_audio_pressed() -> void:
	if !audio_settings_open:
		audio_settings_open = true
		graphics_settings_open = false
		$"Control/Audio Settings".visible = true
		$"Control/Graphics Settings".visible = false
	elif graphics_settings_open:
		audio_settings_open = true
		graphics_settings_open = false
		$"Control/Audio Settings".visible = true
		$"Control/Graphics Settings".visible = false
	else: 
		audio_settings_open = false
		$"Control/Audio Settings".visible = false

func _on_master_arrow_left_pressed() -> void:
	Settings.change_master_volume(-1)
	update_text()

func _on_master_arrow_right_pressed() -> void:
	Settings.change_master_volume(1)
	update_text()

func _on_music_arrow_left_pressed() -> void:
	Settings.change_music_volume(-1)
	update_text()

func _on_music_arrow_right_pressed() -> void:
	Settings.change_music_volume(1)
	update_text()

func _on_sound_arrow_left_pressed() -> void:
	Settings.change_sound_volume(-1)
	update_text()

func _on_sound_arrow_right_pressed() -> void:
	Settings.change_sound_volume(1)
	update_text()
