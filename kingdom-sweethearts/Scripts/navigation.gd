extends Node2D

var is_inventory_open = false

@onready var home_fx = preload("res://Audio/Sound/Door OpenClose.wav")
@onready var scroll_fx = preload("res://Audio/Sound/Scroll Unfurl.wav")
@onready var inventory_fx = preload("res://Audio/Sound/Satchel OpenClose.wav")
@onready var book_fx = preload("res://Audio/Sound/Book OpenClose.wav")

func _ready() -> void:
	if GlobalTracker.unread_scrolls:
		$"Scroll Icon/Sparkle".visible = true
	else:
		$"Scroll Icon/Sparkle".visible = false
	
	if get_tree().current_scene.scene_file_path == "res://Scenes/Locations/dialogue.tscn":
		for icon in [$"Home Icon", $"Scroll Icon", $"Map Icon", $"Inventory Icon", $"Book Icon"]:
			icon.disabled = true
			icon.self_modulate = Color(0.5, 0.5, 0.5)

func _input(event: InputEvent) -> void:
	if !is_inventory_open:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not ($Inventory.get_global_rect().has_point(event.position)):
				if get_tree().current_scene.scene_file_path == "res://Scenes/Locations/dialogue.tscn":
					$"Inventory Confirmation".visible = true
				else:
					$Inventory.visible = false
					is_inventory_open = false
					get_viewport().set_input_as_handled()

func _on_home_icon_pressed() -> void:
	GlobalAudio.play_fx(home_fx, 10)
	GlobalTracker.is_scrolls_open = false
	get_tree().change_scene_to_file("res://Scenes/Locations/home_desk.tscn")

func _on_scroll_icon_pressed() -> void:
	GlobalAudio.play_fx(scroll_fx, 0)
	if GlobalTracker.is_scrolls_open == false:
		if GlobalTracker.scroll_count < 2:
			$"Scroll Icon".disabled = false
			get_tree().change_scene_to_file("res://Scenes/scrolls.tscn")
		else:
			var review_scrolls = load("res://Scenes/review_scrolls.tscn").instantiate()
			get_tree().current_scene.add_child(review_scrolls)
	else:
		$"Scroll Icon".disabled = true

func _on_map_icon_pressed() -> void:
	GlobalAudio.play_fx(home_fx, 10)
	GlobalTracker.is_scrolls_open = false
	get_tree().change_scene_to_file("res://Scenes/map.tscn")

func _on_inventory_icon_pressed() -> void:
	GlobalAudio.play_fx(inventory_fx, 0)
	GlobalTracker.is_scrolls_open = false
	$Inventory.update_slots()
	
	if is_inventory_open:
		$Inventory.visible = false
		is_inventory_open = false
	else:
		$Inventory.visible = true
		is_inventory_open = true

func _on_book_icon_pressed() -> void:
	GlobalAudio.play_fx(book_fx, 10)
	GlobalTracker.is_scrolls_open = false
	get_tree().change_scene_to_file("res://Scenes/kingdom_book.tscn")


func open_inventory_for_dialogue() -> Array[ShopsResource]:
	$Inventory.handing_items_over = true
	$Inventory.update_slots()
	$Inventory.visible = true
	$"Item Confirmation".visible = true
	is_inventory_open = true
	
	var items_handed_over: Array[ShopsResource] = await $Inventory.items_confirmed
	
	$Inventory.handing_items_over = false
	$Inventory.update_slots()
	$Inventory.visible = false
	$"Item Confirmation".visible = false
	is_inventory_open = false
	
	return items_handed_over

func _on_yes_pressed() -> void:
	$Inventory.confirm_selection()
	$"Inventory Confirmation".visible = false

func _on_no_pressed() -> void:
	$"Inventory Confirmation".visible = false

func _on_item_confirmation_pressed() -> void:
	$Inventory.confirm_selection()
