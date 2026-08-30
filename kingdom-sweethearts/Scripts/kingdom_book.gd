extends Node2D

@onready var page_title: Label = $"CanvasLayer/Set of Pages/Page Title"
@onready var crest: Sprite2D = $"CanvasLayer/Set of Pages/Crest"
@onready var page_content: Label = $"CanvasLayer/Set of Pages/Page Content"


var sets_of_pages = [preload("res://Resources/Kingdom Book Pages/Uurais.tres"),
					 preload("res://Resources/Kingdom Book Pages/Oceirea.tres"),
					 preload("res://Resources/Kingdom Book Pages/Wildegon.tres"),
					 preload("res://Resources/Kingdom Book Pages/Mystifirr.tres"),
					 preload("res://Resources/Kingdom Book Pages/Vigoust.tres"),
					 preload("res://Resources/Kingdom Book Pages/Crathod.tres"),
					 preload("res://Resources/Kingdom Book Pages/Philsopoll.tres")]

var current_set_index = 0

func _ready() -> void:
	update_book_pages()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not $"CanvasLayer/Set of Pages".get_global_rect().has_point(event.position):
				get_tree().change_scene_to_file("res://Scenes/home_desk.tscn")

func _on_ribbon_arrow_next_pressed() -> void:
	next_set_of_pages()

func _on_ribbon_arrow_previous_pressed() -> void:
	previous_set_of_pages()

func _on_flip_page_right_pressed() -> void:
	next_set_of_pages()

func _on_flip_page_left_pressed() -> void:
	previous_set_of_pages()


func next_set_of_pages():
	if current_set_index < sets_of_pages.size() - 1:
		current_set_index += 1
		update_book_pages()

func previous_set_of_pages():
	if current_set_index > 0:
		current_set_index -= 1
		update_book_pages()

func update_book_pages():
	var current_pages = sets_of_pages[current_set_index]
	page_title.text = current_pages.page_title
	crest.texture = current_pages.crest
	page_content.text = "\n\n".join(current_pages.page_content)
