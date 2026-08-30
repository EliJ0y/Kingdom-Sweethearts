extends Node2D


@onready var maptown_bgm = preload("res://Audio/Music/KSH_MapTown.wav")
@onready var door_fx = preload("res://Audio/Sound/Door OpenClose.wav")
func _ready() -> void:
	GlobalAudio.play_music(maptown_bgm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_home_icon_pressed() -> void:
	GlobalAudio.play_fx(door_fx)
	get_tree().change_scene_to_file("res://Scenes/Locations/home_desk.tscn")

func _on_craft_shop_icon_pressed() -> void:
	GlobalAudio.play_fx(door_fx)
	get_tree().change_scene_to_file("res://Scenes/Locations/craft_shop.tscn")

func _on_gazebo_icon_pressed() -> void:
	GlobalAudio.play_fx(door_fx)
	get_tree().change_scene_to_file("res://Scenes/Locations/dialogue.tscn")

func _on_bakery_icon_pressed() -> void:
	GlobalAudio.play_fx(door_fx)
	get_tree().change_scene_to_file("res://Scenes/Locations/bakery.tscn")

func _on_florist_icon_pressed() -> void:
	GlobalAudio.play_fx(door_fx)
	get_tree().change_scene_to_file("res://Scenes/Locations/florist.tscn")
