extends Node

var new_game = true
var current_level = 1

var levels = [preload("res://Resources/Levels/Level_1.tres"), 
			  preload("res://Resources/Levels/Level_2.tres"),
			  preload("res://Resources/Levels/Level_3.tres")]

var player_inventory = preload("res://Resources/Player_Inventory.tres")
var total_coins = 0
var scroll_count = 0

var gazebo_first_visit = true

func get_current_level() -> LevelsResource:
	return levels[current_level - 1]

func next_level():
	if current_level < levels.size():
		current_level += 1
		scroll_count = 0
