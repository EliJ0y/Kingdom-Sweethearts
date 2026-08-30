extends Node2D

@onready var text_1: Label = $"CanvasLayer/Opened Scroll/Text 1"
@onready var text_2: Label = $"CanvasLayer/Opened Scroll/Text 2"

var level_number
var scroll_1
var scroll_2
var scroll_1_pressed = true


func _ready() -> void:
	GlobalTracker.is_scrolls_open = true
	level_number = GlobalTracker.get_current_level()
	scroll_1 = level_number.scrolls[0]
	text_1.text = "\n\n".join(scroll_1.lines)
	text_1.add_theme_font_override("font", scroll_1.font)
	scroll_2 = level_number.scrolls[1]
	text_2.text = "\n\n".join(scroll_2.lines)
	text_2.add_theme_font_override("font", scroll_2.font)
	
	text_1.visible_characters = -1
	text_2.hide()

func _on_ribbon_arrow_pressed() -> void:
	if scroll_1_pressed:
		scroll_1_pressed = false
		text_1.hide()
		text_2.show()
		text_2.visible_characters = -1
		GlobalTracker.is_scrolls_open = false
		$"CanvasLayer/Opened Scroll/Ribbon Arrow/Next Scroll".hide()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow/Finish Reading".show()
	else:
		GlobalTracker.is_scrolls_open = false
		queue_free()
