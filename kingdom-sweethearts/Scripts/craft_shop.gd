extends Node2D

@onready var description: Label = $"CanvasLayer/Shop Panel/Description"
@onready var price: Label = $"CanvasLayer/Shop Panel/Coins (Cost)/Price"

var plain_bundle = preload("res://Resources/Plain_Bundle.tres")
var plain_bundle_description = plain_bundle.description
var plain_bundle_price = plain_bundle.price

var plain_stack = preload("res://Resources/Plain_Stack.tres")
var plain_stack_description = plain_stack.description
var plain_stack_price = plain_stack.price

var fancy_bundle = preload("res://Resources/Fancy_Bundle.tres")
var fancy_bundle_description = fancy_bundle.description
var fancy_bundle_price = fancy_bundle.price

var fancy_stack = preload("res://Resources/Fancy_Stack.tres")
var fancy_stack_description = fancy_stack.description
var fancy_stack_price = fancy_stack.price

var ornate_bundle = preload("res://Resources/Ornate_Bundle.tres")
var ornate_bundle_description = ornate_bundle.description
var ornate_bundle_price = ornate_bundle.price


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_plain_bundle_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	description.text = plain_bundle_description
	price.text = plain_bundle_price

func _on_plain_stack_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	description.text = plain_stack_description
	price.text = plain_stack_price

func _on_fancy_bundle_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	description.text = fancy_bundle_description
	price.text = fancy_bundle_price

func _on_fancy_stack_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	description.text = fancy_stack_description
	price.text = fancy_stack_price

func _on_ornate_bundle_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	description.text = ornate_bundle_description
	price.text = ornate_bundle_price


func _on_back_pressed() -> void:
	$"CanvasLayer/Shop Panel".hide()

func _on_buy_item_pressed() -> void:
	pass # Replace with function body.
