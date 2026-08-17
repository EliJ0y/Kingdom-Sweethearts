extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_home_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")

func _on_scroll_icon_pressed() -> void:
	if GlobalTracker.scroll_count < 2:
		get_tree().change_scene_to_file("res://Scenes/scrolls.tscn")

func _on_map_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
