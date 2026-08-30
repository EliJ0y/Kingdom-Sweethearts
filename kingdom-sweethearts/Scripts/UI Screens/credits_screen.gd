extends Node2D
@onready var credit_bgm = preload("res://Audio/Music/KSH_Ending_Theme.wav")
func _input(event: InputEvent) -> void:
	GlobalAudio.play_music(credit_bgm)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_tree().change_scene_to_file("res://Scenes/UI Screens/start_screen.tscn")
