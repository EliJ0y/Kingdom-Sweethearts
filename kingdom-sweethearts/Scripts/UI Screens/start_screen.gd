extends Node2D

@onready var start_bgm = preload("res://Audio/Music/KSH_Opening_Theme.wav")
func _ready() -> void:
	GlobalAudio.play_music(start_bgm)
	GlobalTracker.new_game = true

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Locations/home_desk.tscn")

func _on_settings_pressed() -> void:
	$"Settings Screen".visible = true

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI Screens/credits_screen.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
