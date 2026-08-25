extends Node

var new_game = true
var current_level = 3

var levels = [preload("res://Resources/Levels/Level_1.tres"), 
			  preload("res://Resources/Levels/Level_2.tres"),
			  preload("res://Resources/Levels/Level_3.tres")]

var player_inventory = preload("res://Resources/Player_Inventory.tres")
var total_coins = 0
var scroll_count = 0

var gazebo_first_visit = true

var date_tiers:Array[int] = [-1, -1]

func get_current_level() -> LevelsResource:
	return levels[current_level - 1]

func next_level():
	if current_level < levels.size():
		current_level += 1
		scroll_count = 0

func reset_date_tiers():
	date_tiers = [-1, -1]

func record_gift_tier(character_index: int, tier: int):
	if character_index >= 0 and character_index < date_tiers.size():
		date_tiers[character_index] = tier

func increment_gift_tier(character_index: int):
	if character_index >= 0 and character_index < date_tiers.size():
		date_tiers[character_index] = min(date_tiers[character_index] + 1, 3)

func get_date_ending() -> String:
	var total = date_tiers[0] + date_tiers[1]
	if total <= 1:
		return "hate_ending"
	elif total > 1 and total <= 3:
		return "friendship_ending"
	else:
		return "love_ending"
