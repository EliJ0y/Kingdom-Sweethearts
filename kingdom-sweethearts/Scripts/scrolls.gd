extends Node2D

@onready var home_bgm = preload("res://Audio/Music/KSH_HomeScrolls.wav")

var level_number: LevelsResource
var scroll_1 
var scroll_2 

@onready var opened_scroll_1 = $"CanvasLayer/Opened Scroll/Text 1"
@onready var opened_scroll_2 = $"CanvasLayer/Opened Scroll/Text 2"
@onready var tied_scroll_1 = $"CanvasLayer/Tied Scroll 1"
@onready var tied_scroll_2 = $"CanvasLayer/Tied Scroll 2"

var scroll_1_text
var scroll_2_text

var scroll_coins = 0

var scroll_1_pressed = false
var scroll_2_pressed = false
var stop_text_animation = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_music(home_bgm)
	load_level()
	
func load_level():
	level_number = GlobalTracker.get_current_level()
	scroll_1 = level_number.scrolls[0]
	scroll_1_text = "\n\n".join(scroll_1.lines)
	scroll_2 = level_number.scrolls[1]
	scroll_2_text = "\n\n".join(scroll_2.lines)
	setup_scrolls()
	
func setup_scrolls():
	opened_scroll_1.text = scroll_1_text
	opened_scroll_1.add_theme_font_override("font", scroll_1.font)
	opened_scroll_1.visible_characters = 0
	tied_scroll_1.texture_normal = scroll_1.texturebutton
	
	opened_scroll_2.text = scroll_2_text
	opened_scroll_2.add_theme_font_override("font", scroll_2.font)
	opened_scroll_2.visible_characters = 0
	tied_scroll_2.texture_normal = scroll_2.texturebutton
	
func _input(event: InputEvent) -> void:
	var left_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
	if (Input.is_action_just_pressed("ui_accept") or left_click) && opened_scroll_1.visible_characters > 0:
		stop_text_animation = true
		opened_scroll_1.visible_characters = -1
	if (Input.is_action_just_pressed("ui_accept") or left_click) && opened_scroll_2.visible_characters > 0:
		stop_text_animation = true
		opened_scroll_2.visible_characters = -1


func _on_tied_scroll_1_pressed() -> void:
	tied_scroll_1.disabled = true
	tied_scroll_2.hide()
	scroll_1_pressed = true
	GlobalTracker.scroll_count += 1
	
	var scroll_1_tween = create_tween()
	scroll_1_tween.tween_property($"CanvasLayer/Tied Scroll 1", "position", Vector2(720, 440), 0.8)
	scroll_1_tween.tween_callback(open_scroll_1)

func open_scroll_1() -> void:
	$"Scroll Unfurl SFX".play()
	await get_tree().create_timer(0.2).timeout
	tied_scroll_1.hide()
	$"CanvasLayer/Opened Scroll".show()
	scroll_coins = 80
	_coins_appear()


func _on_tied_scroll_2_pressed() -> void:
	tied_scroll_2.disabled = true
	tied_scroll_1.hide()
	scroll_2_pressed = true
	GlobalTracker.scroll_count += 1
	
	var scroll_2_tween = create_tween()
	scroll_2_tween.tween_property($"CanvasLayer/Tied Scroll 2", "position", Vector2(720, 440), 0.8)
	scroll_2_tween.tween_callback(open_scroll_2)

func open_scroll_2() -> void:
	$"Scroll Unfurl SFX".play()
	await get_tree().create_timer(0.2).timeout
	tied_scroll_2.hide()
	$"CanvasLayer/Opened Scroll".show()
	scroll_coins = 80
	_coins_appear()


func _coins_appear() -> void:
	$"Coin Sparkle SFX".play()
	GlobalTracker.total_coins += scroll_coins
	var coinsappeartween = create_tween()
	coinsappeartween.tween_property($"CanvasLayer/Opened Scroll/Coins Sparkle", "scale", Vector2(5, 5), 0.5)
	coinsappeartween.tween_callback(_coins_update)
	await get_tree().create_timer(1.2).timeout
	
	var coinsdisappeartween = create_tween()
	coinsdisappeartween.tween_property($"CanvasLayer/Opened Scroll/Coins Sparkle", "scale", Vector2(), 0.5)
	coinsdisappeartween.tween_callback(_type_scroll_text)

func _coins_update() -> void:
	$"CanvasLayer/Coin Counter".show()
	$"CanvasLayer/Coin Counter/Coin Text".text = str(GlobalTracker.total_coins) + "G"

func _type_scroll_text() -> void:
	if scroll_1_pressed:
		opened_scroll_2.hide()
		opened_scroll_1.show()
		
		while opened_scroll_1.visible_characters < opened_scroll_1.text.length() && stop_text_animation == false:
			opened_scroll_1.visible_characters += 1
			await get_tree().create_timer(0.03).timeout
		
	if scroll_2_pressed:
		opened_scroll_1.hide()
		opened_scroll_2.show()
		
		while opened_scroll_2.visible_characters < opened_scroll_2.text.length() && stop_text_animation == false:
			opened_scroll_2.visible_characters += 1
			await get_tree().create_timer(0.03).timeout
		
	await get_tree().create_timer(0.5).timeout
	if GlobalTracker.scroll_count < 2:
		if (opened_scroll_1.visible_characters == opened_scroll_1.text.length() || opened_scroll_1.visible_characters == -1):
			await get_tree().create_timer(0.5).timeout
			$"CanvasLayer/Opened Scroll/Ribbon Arrow".show()
			$"CanvasLayer/Opened Scroll/Ribbon Arrow/Next Scroll".show()
		elif (opened_scroll_2.visible_characters == opened_scroll_2.text.length() || opened_scroll_2.visible_characters == -1):
			await get_tree().create_timer(0.5).timeout
			$"CanvasLayer/Opened Scroll/Ribbon Arrow".show()
			$"CanvasLayer/Opened Scroll/Ribbon Arrow/Next Scroll".show()
	else: 
		GlobalTracker.unread_scrolls = false
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".show()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow/Finish Reading".show()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow/Next Scroll".hide()

func _on_ribbon_arrow_pressed() -> void:
	$"CanvasLayer/Opened Scroll".hide()
	stop_text_animation = false
	
	if GlobalTracker.scroll_count < 2:
		if scroll_1_pressed:
			scroll_1_pressed = false
			tied_scroll_2.show()
			$"CanvasLayer/Opened Scroll/Ribbon Arrow".hide()
			opened_scroll_1.hide()
			_on_tied_scroll_2_pressed()
		elif scroll_2_pressed:
			scroll_2_pressed = false
			tied_scroll_1.show()
			$"CanvasLayer/Opened Scroll/Ribbon Arrow".hide()
			opened_scroll_2.hide()
			_on_tied_scroll_1_pressed()
	else:
		get_tree().change_scene_to_file("res://Scenes/Locations/home_desk.tscn")
	return
