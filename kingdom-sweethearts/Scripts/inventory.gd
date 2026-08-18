extends Control

@onready var player_inventory = preload("res://Resources/Player_Inventory.tres")
@onready var slots_list = $NinePatchRect/GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_slots():
	print("slots updated")
	print(player_inventory.inventory)
	for i in range(min(player_inventory.inventory.size(), slots_list.size())):
		slots_list[i].update_item(player_inventory.inventory[i])
