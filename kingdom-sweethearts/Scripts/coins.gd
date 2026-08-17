extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalTracker.total_coins >= 0 && GlobalTracker.scroll_count > 0:
		$"CanvasLayer/Coin Counter".show()
		$"CanvasLayer/Coin Counter/Coin Text".text = str(GlobalTracker.total_coins) + "G"
