extends Node2D

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Start_Dialogue.dialogue"), "start")
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Silvester_Dialogue.dialogue"), "start")

func which_character_speaking():
	pass
