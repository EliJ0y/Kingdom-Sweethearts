extends Node2D

var scroll_1 = GlobalTracker.scrolls_list[0]
var scroll_2 = GlobalTracker.scrolls_list[1]

@onready var opened_scroll_1 = $"CanvasLayer/Opened Scroll/Text 1"
@onready var opened_scroll_2 = $"CanvasLayer/Opened Scroll/Text 2"
@onready var tied_scroll_1 = $"CanvasLayer/Tied Scroll 1"
@onready var tied_scroll_2 = $"CanvasLayer/Tied Scroll 2"

var scroll_text
var scroll_1_text = "\n\n".join(scroll_1.lines)
var scroll_2_text = "\n\n".join(scroll_2.lines)

var scroll_coins = 0
var total_coins = 0

var scroll_1_pressed = false
var scroll_2_pressed = false
var stop_text_animation = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	opened_scroll_1.text = scroll_1_text
	opened_scroll_1.visible_characters = 0
	tied_scroll_1.texture_normal = scroll_1.texturebutton
	
	opened_scroll_2.text = scroll_2_text
	opened_scroll_2.visible_characters = 0
	tied_scroll_2.texture_normal = scroll_2.texturebutton

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Enter") && opened_scroll_1.visible_characters > 0:
		stop_text_animation = true
		opened_scroll_1.visible_characters = -1
	if Input.is_action_just_pressed("Enter") && opened_scroll_2.visible_characters > 0:
		stop_text_animation = true
		opened_scroll_2.visible_characters = -1


func _on_tied_scroll_silv_pressed() -> void:
	tied_scroll_1.disabled = true 
	tied_scroll_2.hide()
	scroll_1_pressed = true;
	
	var silvtween = create_tween()
	silvtween.tween_property($"CanvasLayer/Tied Scroll (Silv)", "position", Vector2(740, 440), 0.8)
	silvtween.tween_callback(_open_scroll_silv)
	
func _open_scroll_silv() -> void:
	await get_tree().create_timer(0.2).timeout
	tied_scroll_1.hide()
	$"CanvasLayer/Opened Scroll".show()
	scroll_coins = 80
	_coins_appear()


func _on_tied_scroll_kohan_pressed() -> void:
	tied_scroll_2.disabled = true
	tied_scroll_1.hide()
	scroll_2_pressed = true
	
	var kohantween = create_tween()
	kohantween.tween_property($"CanvasLayer/Tied Scroll (Kohan)", "position", Vector2(740, 440), 0.8)
	kohantween.tween_callback(_open_scroll_kohan)

func _open_scroll_kohan() -> void:
	await get_tree().create_timer(0.2).timeout
	tied_scroll_2.hide()
	$"CanvasLayer/Opened Scroll".show()
	scroll_coins = 80
	_coins_appear()


func _coins_appear() -> void:
	total_coins += scroll_coins
	var coinsappeartween = create_tween()
	coinsappeartween.tween_property($"CanvasLayer/Opened Scroll/Coins Sparkle", "scale", Vector2(5, 5), 0.5)
	coinsappeartween.tween_callback(_coins_update)
	await get_tree().create_timer(1.2).timeout
	
	var coinsdisappeartween = create_tween()
	coinsdisappeartween.tween_property($"CanvasLayer/Opened Scroll/Coins Sparkle", "scale", Vector2(), 0.5)
	coinsdisappeartween.tween_callback(_type_scroll_text)

func _coins_update() -> void:
	$"CanvasLayer/Coin Counter".show()
	$"CanvasLayer/Coin Counter/Coin Text".text = str(total_coins)

func _type_scroll_text() -> void:
	if scroll_1_pressed:
		opened_scroll_2.hide()
		opened_scroll_1.show()
		scroll_text = scroll_1_text
		
		while opened_scroll_1.visible_characters < opened_scroll_1.text.length() && stop_text_animation == false:
			opened_scroll_1.visible_characters += 1
			await get_tree().create_timer(0.03).timeout
		
	if scroll_2_pressed:
		opened_scroll_1.hide()
		opened_scroll_2.show()
		scroll_text = scroll_2_text
		
		while opened_scroll_2.visible_characters < opened_scroll_2.text.length() && stop_text_animation == false:
			opened_scroll_2.visible_characters += 1
			await get_tree().create_timer(0.03).timeout
		
	await get_tree().create_timer(0.5).timeout
	
	if opened_scroll_1.visible_characters == opened_scroll_1.text.length() || opened_scroll_1.visible_characters == -1:
		await get_tree().create_timer(0.5).timeout
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".show()
	if opened_scroll_2.visible_characters == opened_scroll_2.text.length() || opened_scroll_2.visible_characters == -1:
		await get_tree().create_timer(0.5).timeout
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".show()

func _on_ribbon_arrow_pressed() -> void:
	$"CanvasLayer/Opened Scroll".hide()
	if scroll_1_pressed:
		tied_scroll_2.show()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".hide()
		_on_tied_scroll_kohan_pressed()
	if scroll_2_pressed:
		tied_scroll_1.show()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".hide()
		_on_tied_scroll_silv_pressed()
