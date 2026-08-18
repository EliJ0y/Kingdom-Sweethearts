extends Panel

@onready var item_display: Sprite2D = $"CenterContainer/Panel/Item Display"

func update_item(item: ShopsResource):
	if !item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
