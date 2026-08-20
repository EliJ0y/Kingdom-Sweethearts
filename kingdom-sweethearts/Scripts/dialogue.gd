extends Node2D

@onready var player_sprite: Sprite2D = $"CanvasLayer/Player Sprite"
@onready var character_sprite: Sprite2D = $"CanvasLayer/Character Sprite"

var is_player_speaking = false
var is_character_speaking = false
var character

var player_sprites = preload("res://Resources/Sprites/Player_Sprites.tres")
var characters = {"Silvester": preload("res://Resources/Sprites/Silvester_Sprites.tres"),
				  }

func _ready() -> void:
	DialogueManager.got_dialogue.connect(dialogue_character_check)
	DialogueManager.dialogue_ended.connect(start_dialogue)
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Start_Dialogue.dialogue"), "start")

func start_dialogue(resource: DialogueResource):
	if resource.resource_path == "res://Dialogue Manager/Start_Dialogue.dialogue":
		$"CanvasLayer/Start Dialogue Button".visible = true

func _on_start_dialogue_button_pressed() -> void:
	$"CanvasLayer/Start Dialogue Button".visible = false
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Silvester_Dialogue.dialogue"), "start")
	
func dialogue_character_check(line: DialogueLine):
	set_speaker(line.character)


func player_animation():
	if is_player_speaking == false:
		player_sprite.texture = player_sprites.idle_sprite
	else:
		player_sprite.texture = player_sprites.talking_sprite

func character_animation():
	if character == null:
		return
	if is_character_speaking == false:
		character_sprite.texture = character.idle_sprite
	else:
		character_sprite.texture = character.talking_sprite

func set_speaker(speaker: String):
	if speaker == null:
		return
	elif speaker  == "Cupid":
		is_player_speaking = true
		is_character_speaking = false
	else:
		is_player_speaking = false
		is_character_speaking = true
		character = characters.get(speaker)
	
	player_animation()
	character_animation()
