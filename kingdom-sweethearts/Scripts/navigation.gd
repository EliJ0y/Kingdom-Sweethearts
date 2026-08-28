extends Node2D

var is_inventory_open = false


func _ready() -> void:
	if GlobalTracker.unread_scrolls:
		$"Scroll Icon/Sparkle".visible = true
	else:
		$"Scroll Icon/Sparkle".visible = false

func _input(event: InputEvent) -> void:
	if !is_inventory_open:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not ($Inventory.get_global_rect().has_point(event.position) or $"Inventory Icon".get_global_rect().has_point(event.position)):
				$Inventory.visible = false
				is_inventory_open = false
				$Inventory.item_selected.emit(null)
				get_viewport().set_input_as_handled()

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
	$Inventory.update_slots()
	if is_inventory_open:
		$Inventory.visible = false
		is_inventory_open = false
	else:
		$Inventory.visible = true
		is_inventory_open = true


func open_inventory_for_dialogue(number_of_requests: int) -> Array[ShopsResource]:
	var items_handed_over: Array[ShopsResource] = []
	$Inventory.update_slots()
	$Inventory.visible = true
	is_inventory_open = true
	
	while items_handed_over.size() < number_of_requests:
		var inventory = $Inventory.player_inventory.inventory
		var item: ShopsResource = await $Inventory.item_selected
		
		if !is_inventory_open or item == null:
			return items_handed_over
		
		var item_index = inventory.find(item)
		if item_index != -1:
			inventory.remove_at(item_index)
			items_handed_over.append(item)
			
		$Inventory.update_slots()
	
	$Inventory.visible = false
	is_inventory_open = false
	
	return items_handed_over
