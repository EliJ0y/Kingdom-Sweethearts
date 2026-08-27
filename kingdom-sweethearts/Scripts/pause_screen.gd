extends Node2D

var is_paused = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	if !is_paused:
		is_paused = true
		show()
	else:
		is_paused = false
		hide()

func _on_resume_pressed() -> void:
	is_paused = false
	hide()

func _on_settings_pressed() -> void:
	$"Settings Screen".visible = true

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
