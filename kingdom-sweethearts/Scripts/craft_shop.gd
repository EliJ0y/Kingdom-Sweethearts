extends Node2D

@onready var description: Label = $"CanvasLayer/Shop Panel/Description"

var plain_bundle = preload("res://Resources/Plain_Bundle.tres")

var plain_bundle_text = plain_bundle.description
var plain_stack_text
var fancy_bundle_text
var fancy_stack_text
var ornate_bundle_text



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_plain_bundle_pressed() -> void:
	$"CanvasLayer/Shop Panel".show()
	description.text = plain_bundle_text

func _on_plain_stack_pressed() -> void:
	pass # Replace with function body.

func _on_fancy_bundle_pressed() -> void:
	pass # Replace with function body.

func _on_fancy_stack_pressed() -> void:
	pass # Replace with function body.

func _on_ornate_bundle_pressed() -> void:
	pass # Replace with function body.
