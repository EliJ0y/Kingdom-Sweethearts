extends Node2D

func _ready() -> void:
	GlobalTracker.new_game = true

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")

func _on_settings_pressed() -> void:
	$"Settings Screen".visible = true

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits_screen.tscn")
