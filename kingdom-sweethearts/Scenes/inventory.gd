extends Control

@onready var player_inventory = preload("res://Resources/Player_Inventory.tres")
@onready var slots_list = $NinePatchRect/GridContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
