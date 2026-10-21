extends Panel

signal item_pressed(item: ShopsResource)

@onready var slot_sprite: Sprite2D = $Slot
@onready var item_display: Sprite2D = $"CenterContainer/Panel/Item Display"

var current_item: ShopsResource = null

func update_item(item: ShopsResource):
	current_item = item
	
	if !item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.texture

func set_highlight(is_highlighted: bool):
	if is_highlighted:
		slot_sprite.self_modulate = Color(1.0, 0.85, 0.3)
	else:
		slot_sprite.self_modulate = Color(1.0, 1.0, 1.0)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if current_item != null:
					item_pressed.emit(current_item)
