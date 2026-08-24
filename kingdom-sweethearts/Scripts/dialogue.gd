extends Node2D

var level_number: LevelsResource


@onready var player_sprite: Sprite2D = $"CanvasLayer/Player Sprite"
@onready var character_sprite: Sprite2D = $"CanvasLayer/Character Sprite"
var player_sprites = preload("res://Resources/Sprites/Player_Sprites.tres")

var is_player_speaking = false
var is_character_speaking = false
var has_character_1_spoken = false
var has_character_2_spoken = false

var character: CharactersResource

var normal_colour = Color(1.0, 1.0, 1.0, 1.0)
var grey_out = Color(0.5, 0.5, 0.5, 1.0)


func _ready() -> void:
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
		character_sprite.visible = false
		DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Connector_Dialogue.dialogue"), "start")
	elif resource == level_number.character_dialogues[1]:
		player_sprite.visible = false
		character_sprite.visible = false
		$"CanvasLayer/Button".visible = true
		$"CanvasLayer/Button/Button Text".text = "Return Home"
	elif resource.resource_path == "res://Dialogue Manager/Connector_Dialogue.dialogue":
		$"CanvasLayer/Button".visible = true
		$"CanvasLayer/Button/Button Text".text = "Start Dialogue"

func _on_button_pressed() -> void:
	$CanvasLayer/Button.visible = false
	if !has_character_1_spoken:
		DialogueManager.show_dialogue_balloon((level_number.character_dialogues[0]), "start")
		has_character_1_spoken = true
	elif !has_character_2_spoken:
		DialogueManager.show_dialogue_balloon((level_number.character_dialogues[1]), "start")
		has_character_2_spoken = true
	else:
		GlobalTracker.next_level()
		get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")
	
func dialogue_character_check(line: DialogueLine):
	set_speaker(line.character)


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
	if speaker == null:
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
