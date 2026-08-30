extends Node2D

@onready var description: Label = $"CanvasLayer/Shop Panel/Description"
@onready var price: Label = $"CanvasLayer/Shop Panel/Coins (Cost)/Price"

var selected_item

var plain_bundle = preload("res://Resources/Craft Shop/Plain_Bundle.tres")
var plain_stack = preload("res://Resources/Craft Shop/Plain_Stack.tres")
var fancy_bundle = preload("res://Resources/Craft Shop/Fancy_Bundle.tres")
var fancy_stack = preload("res://Resources/Craft Shop/Fancy_Stack.tres")
var ornate_bundle = preload("res://Resources/Craft Shop/Ornate_Bundle.tres")

var postcards_coasts = preload("res://Resources/Craft Shop/Postcards_Coasts.tres")
var postcards_deserts = preload("res://Resources/Craft Shop/Postcards_Deserts.tres")
var postcards_forests = preload("res://Resources/Craft Shop/Postcards_Forests.tres")
var postcards_mesas = preload("res://Resources/Craft Shop/Postcards_Mesas.tres")
var postcards_mountains = preload("res://Resources/Craft Shop/Postcards_Mountains.tres")


func update_shop_panel():
	description.text = selected_item.description
	price.text = selected_item.price
	reset_to_buy()

func _on_plain_bundle_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = plain_bundle
	update_shop_panel()

func _on_plain_stack_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = plain_stack
	update_shop_panel()

func _on_fancy_bundle_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = fancy_bundle
	update_shop_panel()

func _on_fancy_stack_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = fancy_stack
	update_shop_panel()

func _on_ornate_bundle_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = ornate_bundle
	update_shop_panel()


func _on_postcards_coast_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = postcards_coasts
	update_shop_panel()

func _on_postcards_deserts_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = postcards_deserts
	update_shop_panel()

func _on_postcards_forests_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = postcards_forests
	update_shop_panel()

func _on_postcards_mesas_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = postcards_mesas
	update_shop_panel()

func _on_postcards_mountains_pressed() -> void:
	$"Paper Rustle SFX".play()
	$"CanvasLayer/Shop Panel".show()
	selected_item = postcards_mountains
	update_shop_panel()


func _on_back_pressed() -> void:
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func _on_buy_item_pressed() -> void:
	if GlobalTracker.total_coins >= int(selected_item.price):
		$"CanvasLayer/Shop Panel/Buy Item".hide()
		$"CanvasLayer/Shop Panel/Confirm".show()

func _on_confirm_pressed() -> void:
	$"Coin Purchase SFX".play()
	GlobalTracker.player_inventory.inventory.append(selected_item)
	GlobalTracker.total_coins -= int(selected_item.price)
	reset_to_buy()
	$"CanvasLayer/Shop Panel".hide()

func reset_to_buy():
	$"CanvasLayer/Shop Panel/Buy Item".show()
	$"CanvasLayer/Shop Panel/Confirm".hide()
