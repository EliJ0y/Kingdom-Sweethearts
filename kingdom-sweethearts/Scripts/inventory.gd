extends Control

signal items_confirmed(items: ShopsResource)

@onready var player_inventory = preload("res://Resources/Player_Inventory.tres")
@onready var slots_list = $NinePatchRect/GridContainer.get_children()

var handing_items_over = false;
var selected_items: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(slots_list.size()):
		slots_list[i].item_pressed.connect(on_slot_item_pressed.bind(i)) #signal from inventory_slot script

func update_slots(): 
	for i in range(slots_list.size()):
		if i < player_inventory.inventory.size():
			slots_list[i].update_item(player_inventory.inventory[i])
		else:
			slots_list[i].update_item(null)

func on_slot_item_pressed(item: ShopsResource, slot_index):
	if item == null:
		return
	if !handing_items_over:
		return
	if selected_items.has(slot_index):
		selected_items.erase(slot_index)
	else:
		selected_items.append(slot_index)
	refresh_highlights()

func refresh_highlights():
	for i in range(slots_list.size()):
		slots_list[i].set_highlight(selected_items.has(i))

func take_selected_items() -> Array[ShopsResource]:
	var chosen_items: Array[ShopsResource] = []
	for index in selected_items:
		chosen_items.append(player_inventory.inventory[index])
	return chosen_items

func remove_selected_items():
	selected_items.sort()
	selected_items.reverse()
	for index in selected_items:
		player_inventory.inventory.remove_at(index)

func confirm_selection():
	var confirmed_items = take_selected_items()
	remove_selected_items()
	selected_items.clear()
	update_slots()
	refresh_highlights()
	items_confirmed.emit(confirmed_items)
