extends Node2D

@onready var description: Label = $"CanvasLayer/Shop Panel/Description"
@onready var price: Label = $"CanvasLayer/Shop Panel/Coins (Cost)/Price"

var selected_item

var trilliums = preload("res://Resources/Florist/Trilliums.tres")
var lavenders = preload("res://Resources/Florist/Lavenders.tres")
var anemones = preload("res://Resources/Florist/Anemones.tres")
var violets = preload("res://Resources/Florist/Violets.tres")
var roses = preload("res://Resources/Florist/Roses.tres")
var pansies = preload("res://Resources/Florist/Pansies.tres")
var carnations = preload("res://Resources/Florist/Carnations.tres")
var clematis = preload("res://Resources/Florist/Clematis.tres")


func update_shop_panel():
	description.text = selected_item.description
	price.text = selected_item.price
	reset_to_buy()

func _on_trilliums_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = trilliums
	update_shop_panel()

func _on_lavenders_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = lavenders
	update_shop_panel()

func _on_anemones_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = anemones
	update_shop_panel()

func _on_violets_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = violets
	update_shop_panel()

func _on_roses_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = roses
	update_shop_panel()

func _on_pansies_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = pansies
	update_shop_panel()

func _on_carnations_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = carnations
	update_shop_panel()

func _on_clematis_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	selected_item = clematis
	update_shop_panel()


func _on_back_pressed() -> void:
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func _on_buy_item_pressed() -> void:
	if GlobalTracker.total_coins >= int(selected_item.price):
		$"CanvasLayer/Shop Panel/Buy Item".hide()
		$"CanvasLayer/Shop Panel/Confirm".show()

func _on_confirm_pressed() -> void:
	GlobalTracker.player_inventory.inventory.append(selected_item)
	GlobalTracker.total_coins -= int(selected_item.price)
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func reset_to_buy():
	$"CanvasLayer/Shop Panel/Buy Item".show()
	$"CanvasLayer/Shop Panel/Confirm".hide()
