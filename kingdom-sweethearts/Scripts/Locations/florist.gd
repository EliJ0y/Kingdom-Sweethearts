extends Node2D

@onready var description: Label = $"CanvasLayer/Shop Panel/Description"
@onready var price: Label = $"CanvasLayer/Shop Panel/Coins (Cost)/Price"

var selected_item
var number_of_stalks: int 

var trilliums = preload("res://Resources/Florist/Trilliums.tres")
var lavenders = preload("res://Resources/Florist/Lavenders.tres")
var anemones = preload("res://Resources/Florist/Anemones.tres")
var violets = preload("res://Resources/Florist/Violets.tres")
var roses = preload("res://Resources/Florist/Roses.tres")
var pansies = preload("res://Resources/Florist/Pansies.tres")
var carnations = preload("res://Resources/Florist/Carnations.tres")
var clematis = preload("res://Resources/Florist/Clematis.tres")

@onready var maptown_bgm = preload("res://Audio/Music/KSH_MapTown.wav")
@onready var flower_fx = preload("res://Audio/Sound/Flower Rustle.wav")
@onready var coin_fx = preload("res://Audio/Sound/Coin Purchase.wav")

func _ready() -> void:
	GlobalAudio.play_music(maptown_bgm)

func update_shop_panel():
	description.text = selected_item.description
	price.text = selected_item.price
	reset_to_buy()

func _on_trilliums_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = trilliums
	update_shop_panel()

func _on_lavenders_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = lavenders
	update_shop_panel()

func _on_anemones_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = anemones
	update_shop_panel()

func _on_violets_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = violets
	update_shop_panel()

func _on_roses_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = roses
	update_shop_panel()

func _on_pansies_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = pansies
	update_shop_panel()

func _on_carnations_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = carnations
	update_shop_panel()

func _on_clematis_pressed() -> void:
	GlobalAudio.play_fx(flower_fx, 0)
	$"CanvasLayer/Shop Panel".show()
	selected_item = clematis
	update_shop_panel()


func _on_back_pressed() -> void:
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func _on_buy_1_stalk_pressed() -> void:
	number_of_stalks = 1
	if GlobalTracker.total_coins >= (int(selected_item.price) * number_of_stalks):
		$"CanvasLayer/Shop Panel/Buy 1 Stalk".hide()
		$"CanvasLayer/Shop Panel/Buy 2 Stalks".hide()
		$"CanvasLayer/Shop Panel/Buy 5 Stalks".hide()
		$"CanvasLayer/Shop Panel/Confirm".show()

func _on_buy_2_stalks_pressed() -> void:
	number_of_stalks = 2
	if GlobalTracker.total_coins >= (int(selected_item.price) * number_of_stalks):
		$"CanvasLayer/Shop Panel/Buy 1 Stalk".hide()
		$"CanvasLayer/Shop Panel/Buy 2 Stalks".hide()
		$"CanvasLayer/Shop Panel/Buy 5 Stalks".hide()
		$"CanvasLayer/Shop Panel/Confirm".show()

func _on_buy_5_stalks_pressed() -> void:
	number_of_stalks = 5
	if GlobalTracker.total_coins >= (int(selected_item.price) * number_of_stalks):
		$"CanvasLayer/Shop Panel/Buy 1 Stalk".hide()
		$"CanvasLayer/Shop Panel/Buy 2 Stalks".hide()
		$"CanvasLayer/Shop Panel/Buy 5 Stalks".hide()
		$"CanvasLayer/Shop Panel/Confirm".show()

func _on_confirm_pressed() -> void:
	if GlobalTracker.player_inventory.inventory.size() < 8:
		GlobalAudio.play_fx(coin_fx, -25)
		for stalks in number_of_stalks:
			GlobalTracker.player_inventory.inventory.append(selected_item)
		GlobalTracker.total_coins -= (int(selected_item.price) * number_of_stalks)
		reset_to_buy()
		$"CanvasLayer/Shop Panel".hide()

func reset_to_buy():
	$"CanvasLayer/Shop Panel/Buy 1 Stalk".show()
	$"CanvasLayer/Shop Panel/Buy 2 Stalks".show()
	$"CanvasLayer/Shop Panel/Buy 5 Stalks".show()
	$"CanvasLayer/Shop Panel/Confirm".hide()
