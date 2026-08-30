extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalTracker.new_game == true:
		$Navigation.process_mode = Node.PROCESS_MODE_DISABLED
		$"Kingdom Book".process_mode = Node.PROCESS_MODE_DISABLED
		$Control.visible = true
		$Control/Context.text = "We are deeply honoured to have such an esteemed individual matchmake the kingdom's nobles. Every day, the necessary scrolls shall be delivered to you.\n\nThe kingdom's future lies in your hands!"
	else:
		$Navigation.process_mode = Node.PROCESS_MODE_INHERIT
		$"Kingdom Book".process_mode = Node.PROCESS_MODE_INHERIT
		$Control.visible = false

func _input(event: InputEvent) -> void:
	if GlobalTracker.new_game:
		var left_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
		if Input.is_action_just_pressed("ui_accept") or left_click:
			$Control.visible = false
			GlobalTracker.new_game = false
			$Panel.visible = true
			$"Scroll Icon".visible = true

func _on_scroll_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/scrolls.tscn")
	$Panel.visible = false
	$"Scroll Icon".visible = false

func _on_kingdom_book_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/kingdom_book.tscn")
