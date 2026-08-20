extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_home_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")

func _on_craft_shop_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/craft_shop.tscn")

func _on_gazebo_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/dialogue.tscn")

func _on_bakery_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/bakery.tscn")

func _on_florist_icon_pressed() -> void:
	pass
