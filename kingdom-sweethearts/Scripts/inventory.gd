extends Control

signal item_selected(item:ShopsResource)

@onready var player_inventory = preload("res://Resources/Player_Inventory.tres")
@onready var slots_list = $NinePatchRect/GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for slot in slots_list:
		slot.item_pressed.connect(on_slot_item_pressed) #signal from inventory_slot script

func update_slots(): 
	for i in range(slots_list.size()):
		if i < player_inventory.inventory.size():
			slots_list[i].update_item(player_inventory.inventory[i])
		else:
			slots_list[i].update_item(null)

func on_slot_item_pressed(item: ShopsResource):
	if item == null:
		return
	
	item_selected.emit(item)
