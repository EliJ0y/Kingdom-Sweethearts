extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tied_scroll_silv_pressed() -> void:
	$"CanvasLayer/Tied Scroll (Silv)".disabled = true 
	$"CanvasLayer/Tied Scroll (Kohan)".hide()
	
	var SilvTween = create_tween()
	SilvTween.tween_property($"CanvasLayer/Tied Scroll (Silv)", "position", Vector2(740, 440), 0.8)
	SilvTween.tween_callback(_open_scroll_silv)
	
func _open_scroll_silv() -> void:
	await get_tree().create_timer(0.2).timeout
	$"CanvasLayer/Tied Scroll (Silv)".hide()
	$"CanvasLayer/Opened Scroll".show()

func _on_tied_scroll_kohan_pressed() -> void:
	$"CanvasLayer/Tied Scroll (Kohan)".disabled = true
	$"CanvasLayer/Tied Scroll (Silv)".hide()
	var KohanTween = create_tween()
	KohanTween.tween_property($"CanvasLayer/Tied Scroll (Kohan)", "position", Vector2(740, 440), 0.8)
