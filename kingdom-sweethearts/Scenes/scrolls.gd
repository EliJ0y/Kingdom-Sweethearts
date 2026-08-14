extends Node2D

@onready var silv_scroll = $"CanvasLayer/Opened Scroll/Silv Scroll"
var scroll_text = "Hail and well met from Oceirea! 

I am Duke Silvester, who is set to be matchmade with Duke Kohan from Wildegon in three days.

I have heard much of his strength and admire him greatly! I do hope these feelings are mutual. 

To help you in your preparations, I have heard that Duke Kohan has a soft spot for flowers. Perhaps a bouquet would be a nice gift? 

I eagerly anticipate meeting him!"

var scroll_coins = "0"
var total_coins = 0

var silv_scroll_pressed = false
var kohan_scroll_pressed = false
var stop_text_animation = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	silv_scroll.text = scroll_text
	silv_scroll.show()
	silv_scroll.visible_characters = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Enter") && silv_scroll.visible_characters > 0:
		stop_text_animation = true
		silv_scroll.visible_characters = -1


func _on_tied_scroll_silv_pressed() -> void:
	$"CanvasLayer/Tied Scroll (Silv)".disabled = true 
	$"CanvasLayer/Tied Scroll (Kohan)".hide()
	silv_scroll_pressed = true;
	
	var SilvTween = create_tween()
	SilvTween.tween_property($"CanvasLayer/Tied Scroll (Silv)", "position", Vector2(740, 440), 0.8)
	SilvTween.tween_callback(_open_scroll_silv)
	
func _open_scroll_silv() -> void:
	await get_tree().create_timer(0.2).timeout
	$"CanvasLayer/Tied Scroll (Silv)".hide()
	$"CanvasLayer/Opened Scroll".show()
	scroll_coins = 80
	_coins_appear()


func _on_tied_scroll_kohan_pressed() -> void:
	$"CanvasLayer/Tied Scroll (Kohan)".disabled = true
	$"CanvasLayer/Tied Scroll (Silv)".hide()
	var kohan_scroll_pressed = false
	
	var KohanTween = create_tween()
	KohanTween.tween_property($"CanvasLayer/Tied Scroll (Kohan)", "position", Vector2(740, 440), 0.8)
	KohanTween.tween_callback(_open_scroll_kohan)

func _open_scroll_kohan() -> void:
	await get_tree().create_timer(0.2).timeout
	$"CanvasLayer/Tied Scroll (Kohan)".hide()
	$"CanvasLayer/Opened Scroll".show()
	scroll_coins = 80
	_coins_appear()


func _coins_appear() -> void:
	total_coins += scroll_coins
	var CoinsAppearTween = create_tween()
	CoinsAppearTween.tween_property($"CanvasLayer/Opened Scroll/Coins Sparkle", "scale", Vector2(5, 5), 0.5)
	CoinsAppearTween.tween_callback(_coins_update)
	await get_tree().create_timer(1.2).timeout
	
	var CoinsDisappearTween = create_tween()
	CoinsDisappearTween.tween_property($"CanvasLayer/Opened Scroll/Coins Sparkle", "scale", Vector2(), 0.5)
	CoinsDisappearTween.tween_callback(_type_scroll_silv)

func _coins_update() -> void:
	$"CanvasLayer/Coin Counter".show()
	$"CanvasLayer/Coin Counter/Coin Text".text = str(total_coins)

func _type_scroll_silv() -> void:
	await get_tree().create_timer(0.5).timeout
	silv_scroll.visible_characters = 0
	
	while silv_scroll.visible_characters < silv_scroll.text.length() && stop_text_animation == false:
		silv_scroll.visible_characters += 1
		await get_tree().create_timer(0.03).timeout
	
	if silv_scroll.visible_characters == silv_scroll.text.length() || silv_scroll.visible_characters == -1:
		await get_tree().create_timer(0.5).timeout
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".show()

func _on_ribbon_arrow_pressed() -> void:
	$"CanvasLayer/Opened Scroll".hide()
	if silv_scroll_pressed:
		$"CanvasLayer/Tied Scroll (Kohan)".show()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".hide()
		_on_tied_scroll_kohan_pressed()
	if kohan_scroll_pressed:
		$"CanvasLayer/Tied Scroll (Silv)".show()
		$"CanvasLayer/Opened Scroll/Ribbon Arrow".hide()
		_on_tied_scroll_silv_pressed()
