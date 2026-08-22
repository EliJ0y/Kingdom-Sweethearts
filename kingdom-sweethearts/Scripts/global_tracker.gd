extends Node

var current_level = 1

var scrolls_list = [preload("res://Resources/Scrolls/Silvester_Scroll.tres"), 
					preload("res://Resources/Scrolls/Kohan_Scroll.tres"),
					preload("res://Resources/Scrolls/Farai_Scroll.tres"),
					preload("res://Resources/Scrolls/Rei_Scroll.tres"),
					preload("res://Resources/Scrolls/Nasim_Scroll.tres"),
					preload("res://Resources/Scrolls/Izzy_Scroll.tres")]

var player_inventory = preload("res://Resources/Player_Inventory.tres")
var total_coins = 100
var scroll_count = 0

var gazebo_first_visit = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
