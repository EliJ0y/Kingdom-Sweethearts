extends Node2D

var level_number: LevelsResource

@onready var player_sprite: Sprite2D = $"CanvasLayer/Player Sprite"
@onready var character_sprite: Sprite2D = $"CanvasLayer/Character Sprite"
@onready var character_sprite_date: Sprite2D = $"CanvasLayer/Character Sprite Date"
@onready var navigation: Node2D = $CanvasLayer/Navigation
@onready var dialogue_bgm = preload("res://Audio/Music/KSH_Gazebo.wav")


var player_sprites = preload("res://Resources/Sprites/Player_Sprites.tres")

var is_player_speaking = false
var is_character_speaking = false
var has_character_1_spoken = false
var has_character_2_spoken = false
var is_date_scene = false

var character: CharactersResource
var character_1: CharactersResource
var character_2: CharactersResource

var completed_item_requests: Array[int] = []
var item_wrong_specific = false
var item_wrong_type = false
var character_index = -1
var ending_result

var normal_colour = Color(1.0, 1.0, 1.0, 1.0)
var grey_out = Color(0.5, 0.5, 0.5, 1.0)


func _ready() -> void:
	GlobalAudio.play_music(dialogue_bgm)
	level_number = GlobalTracker.get_current_level()

	DialogueManager.got_dialogue.connect(dialogue_character_check)
	DialogueManager.dialogue_ended.connect(start_dialogue)
	DialogueManager.dialogue_ended.connect(end_dialogue)
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Start_Dialogue.dialogue"), "start")

func start_dialogue(resource: DialogueResource):
	if resource.resource_path == "res://Dialogue Manager/Start_Dialogue.dialogue":
		$CanvasLayer/Button.visible = true
		$"CanvasLayer/Button/Button Text".text = "Start Dialogue"

func end_dialogue(resource: DialogueResource):
	if resource == level_number.character_dialogues[0]:
		character_1 = character
		character_sprite.visible = false
		DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Connector_Dialogue.dialogue"), "start")
		
	elif resource.resource_path == "res://Dialogue Manager/Connector_Dialogue.dialogue":
		$"CanvasLayer/Button".visible = true
		$"CanvasLayer/Button/Button Text".text = "Start Dialogue"
		
	elif resource == level_number.character_dialogues[1]:
		character_2 = character
		date_dialogue()
		
	elif resource.resource_path == "res://Dialogue Manager/Date_Dialogue.dialogue":
		is_date_scene = false
		player_sprite.visible = false
		character_sprite_date.visible = false
		character_sprite.visible = false
		
		$"CanvasLayer/Ending Title Panel".visible = true
		if ending_result == "hate_ending":
			$"CanvasLayer/Ending Title Panel/Ending Title".text = "Hate Ending"
		elif ending_result == "friendship_ending":
			$"CanvasLayer/Ending Title Panel/Ending Title".text = "Friendship Ending"
		else:
			$"CanvasLayer/Ending Title Panel/Ending Title".text = "Love Ending"
		
		$"CanvasLayer/Button".visible = true
		if GlobalTracker.is_last_level():
			$"CanvasLayer/Button/Button Text".text = "Thank you for playing!"
		else:
			$"CanvasLayer/Button/Button Text".text = "Return Home"

func date_dialogue():
	is_date_scene = true
	player_sprite.visible = false
	character_sprite_date.visible = true
	character_sprite.visible = true
	
	character_sprite_date.texture = character_1.character_sprites.talking_sprite
	character_sprite.texture = character_2.character_sprites.talking_sprite
	character_sprite_date.modulate = normal_colour
	character_sprite.modulate = normal_colour
	
	ending_result = GlobalTracker.get_date_ending()
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Date_Dialogue.dialogue"), ending_result)

func _on_button_pressed() -> void:
	$CanvasLayer/Button.visible = false
	if !has_character_1_spoken:
		character_index = 0
		DialogueManager.show_dialogue_balloon((level_number.character_dialogues[0]), "start")
		has_character_1_spoken = true
	elif !has_character_2_spoken:
		character_index = 1
		DialogueManager.show_dialogue_balloon((level_number.character_dialogues[1]), "start")
		has_character_2_spoken = true
	else:
		if GlobalTracker.is_last_level():
			get_tree().change_scene_to_file("res://Scenes/UI Screens/credits_screen.tscn")
		else:
			GlobalTracker.next_level()
			get_tree().change_scene_to_file("res://Scenes/Locations/home_desk.tscn")
	
func dialogue_character_check(line: DialogueLine):
	set_speaker(line.character)
	
func record_tier_result(tier: int):
	GlobalTracker.record_gift_tier(character_index, tier)

func increase_tier_for_correct_choice():
	GlobalTracker.increment_gift_tier(character_index)


func player_animation():
	if is_player_speaking == false:
		player_sprite.texture = player_sprites.idle_sprite
		player_sprite.modulate = grey_out
	else:
		player_sprite.texture = player_sprites.talking_sprite
		player_sprite.modulate = normal_colour

func character_animation():
	if character == null:
		return
	character_sprite.visible = true
	if is_character_speaking == false:
		character_sprite.texture = character.character_sprites.idle_sprite
		character_sprite.modulate = grey_out
	else:
		character_sprite.texture = character.character_sprites.talking_sprite
		character_sprite.modulate = normal_colour

func set_speaker(speaker: String):
	if speaker == null or is_date_scene:
		return
	if speaker  == "Cupid":
		is_player_speaking = true
		is_character_speaking = false
	else:
		is_player_speaking = false
		is_character_speaking = true
		character = get_character(speaker)
	
	player_animation()
	character_animation()

func get_character(character_name: String) -> CharactersResource:
	for character_data in level_number.characters:
		if character_data.character_name == character_name:
			return character_data
	return null


func start_item_requests(number_of_requests: int):
	reset_item_requests()
	var items_handed_over: Array[ShopsResource] = await navigation.open_inventory_for_dialogue(number_of_requests)
	if items_handed_over.size() < number_of_requests:
		item_wrong_type = true
		return 
	for item in items_handed_over:
		item_handed_over(item)

func reset_item_requests():
	completed_item_requests.clear()
	item_wrong_specific = false
	item_wrong_type = false

func item_handed_over(item: ShopsResource):
	var same_item_type = false
	
	for i in range(character.item_requests.size()):
		if completed_item_requests.has(i):
			continue
		var request = character.item_requests[i]
			
		for acceptable_item in request.acceptable_items:
			if item == acceptable_item:
				completed_item_requests.append(i)
				return
			if item.item_type == acceptable_item.item_type:
				same_item_type = true #don't immediately set last_item_wrong_specific = true as the item could be acceptable for another request
	
	if same_item_type:
		item_wrong_specific = true
	else:
		item_wrong_type = true

func all_requests_completed() -> bool:
	return completed_item_requests.size() >= character.item_requests.size()
	
func wrong_specific_item() -> bool:
	return item_wrong_specific

func wrong_item_type() -> bool:
	return item_wrong_type
