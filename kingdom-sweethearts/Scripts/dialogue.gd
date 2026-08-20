extends Node2D

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(start_dialogue)
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Start_Dialogue.dialogue"), "start")

func start_dialogue(resource: DialogueResource):
	if resource.resource_path == "res://Dialogue Manager/Start_Dialogue.dialogue":
		$"CanvasLayer/Start Dialogue Button".visible = true

func _on_start_dialogue_button_pressed() -> void:
	$"CanvasLayer/Start Dialogue Button".visible = false
	DialogueManager.show_dialogue_balloon(load("res://Dialogue Manager/Silvester_Dialogue.dialogue"), "start")
