extends Node2D

var is_inventory_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_home_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")

func _on_scroll_icon_pressed() -> void:
	if get_tree().current_scene.scene_file_path == "res://Scenes/home_desk.tscn":
		$"Scroll Icon".disabled = false
		if GlobalTracker.scroll_count < 2:
			get_tree().change_scene_to_file("res://Scenes/scrolls.tscn")
	else:
		$"Scroll Icon".disabled = true

func _on_map_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/map.tscn")

func _on_inventory_icon_pressed() -> void:
	if is_inventory_open:
		$Inventory.visible = false
		is_inventory_open = false
	else:
		$Inventory.visible = true
		is_inventory_open = true
