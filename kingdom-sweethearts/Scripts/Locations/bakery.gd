extends Node2D

@onready var description: Label = $"CanvasLayer/Shop Panel/Description"
@onready var price: Label = $"CanvasLayer/Shop Panel/Coins (Cost)/Price"

var selected_item

var baguettes = preload("res://Resources/Bakery/Baguettes.tres")
var cinnamon_rolls = preload("res://Resources/Bakery/Cinnamon_Rolls.tres")
var loaf_of_bread = preload("res://Resources/Bakery/Loaf_of_Bread.tres")
var apple_strudels = preload("res://Resources/Bakery/Apple_Strudels.tres")
var glazed_donuts = preload("res://Resources/Bakery/Glazed_Donuts.tres")
var chocolate_bread = preload("res://Resources/Bakery/Chocolate_Bread.tres")
var plain_muffins = preload("res://Resources/Bakery/Plain_Muffins.tres")
var croissants = preload("res://Resources/Bakery/Croissants.tres")

@onready var maptown_bgm = preload("res://Audio/Music/KSH_MapTown.wav")
@onready var bread_fx = preload("res://Audio/Sound/Bread Crunch.wav")
@onready var coin_fx = preload("res://Audio/Sound/Coin Purchase.wav")

func _ready() -> void:
	GlobalAudio.play_music(maptown_bgm)

func update_shop_panel():
	description.text = selected_item.description
	price.text = selected_item.price
	reset_to_buy()

func _on_glazed_donuts_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = glazed_donuts
	update_shop_panel()

func _on_chocolate_bread_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = chocolate_bread
	update_shop_panel()

func _on_plain_muffins_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = plain_muffins
	update_shop_panel()

func _on_croissants_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = croissants
	update_shop_panel()

func _on_apple_strudels_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = apple_strudels
	update_shop_panel()

func _on_loaf_of_bread_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = loaf_of_bread
	update_shop_panel()

func _on_cinammon_rolls_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = cinnamon_rolls
	update_shop_panel()

func _on_baguettes_pressed() -> void:
	GlobalAudio.play_fx(bread_fx, -5)
	$"CanvasLayer/Shop Panel".show()
	selected_item = baguettes
	update_shop_panel()


func _on_back_pressed() -> void:
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func _on_buy_item_pressed() -> void:
	if GlobalTracker.total_coins >= int(selected_item.price):
		$"CanvasLayer/Shop Panel/Buy Item".hide()
		$"CanvasLayer/Shop Panel/Confirm".show()

func _on_confirm_pressed() -> void:
	GlobalAudio.play_fx(coin_fx, -25)
	GlobalTracker.player_inventory.inventory.append(selected_item)
	GlobalTracker.total_coins -= int(selected_item.price)
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func reset_to_buy():
	$"CanvasLayer/Shop Panel/Buy Item".show()
	$"CanvasLayer/Shop Panel/Confirm".hide()
