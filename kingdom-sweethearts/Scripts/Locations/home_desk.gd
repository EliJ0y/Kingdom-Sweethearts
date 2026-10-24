extends Node2D
@onready var home_bgm = preload("res://Audio/Music/KSH_HomeScrolls.wav")
@onready var book_fx = preload("res://Audio/Sound/Book OpenClose.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalAudio.play_music(home_bgm)
	show_scrolls_holder()
	if GlobalTracker.new_game == true:
		$Navigation.process_mode = Node.PROCESS_MODE_DISABLED
		$"Kingdom Book".process_mode = Node.PROCESS_MODE_DISABLED
		$"Holder Control".process_mode = Node.PROCESS_MODE_DISABLED
		$"Context Control".visible = true
		$"Context Control/Context".text = "We are deeply honoured to have such an esteemed individual matchmake the kingdom's nobles. Every day, the necessary scrolls shall be delivered to you.\n\nThe kingdom's future lies in your hands!"
	else:
		$Navigation.process_mode = Node.PROCESS_MODE_INHERIT
		$"Kingdom Book".process_mode = Node.PROCESS_MODE_INHERIT
		$"Holder Control".process_mode = Node.PROCESS_MODE_INHERIT
		$"Context Control".visible = false

func _input(event: InputEvent) -> void:
	if GlobalTracker.new_game:
		var left_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
		if Input.is_action_just_pressed("ui_accept") or left_click:
			$"Context Control".visible = false
			GlobalTracker.new_game = false
			$Panel.visible = true
			$"Scroll Icon".visible = true

func _on_scroll_icon_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/scrolls.tscn")
	$Panel.visible = false
	$"Scroll Icon".visible = false

func _on_kingdom_book_pressed() -> void:
	GlobalAudio.play_fx(book_fx, 10)
	get_tree().change_scene_to_file("res://Scenes/kingdom_book.tscn")


func show_scrolls_holder():
	if GlobalTracker.unread_scrolls == false:
		var level = GlobalTracker.get_current_level()
		$"Holder Control/Scroll 1".visible = true
		$"Holder Control/Scroll 1".texture_normal = level.scrolls[0].texturebutton
		$"Holder Control/Scroll 2".visible = true
		$"Holder Control/Scroll 2".texture_normal = level.scrolls[1].texturebutton

func disable_holder_scrolls(is_disabled: bool):
	$"Holder Control/Scroll 1".disabled = is_disabled
	$"Holder Control/Scroll 2".disabled = is_disabled

func holder_review_scrolls():
	disable_holder_scrolls(true)
	var review_scrolls = load("res://Scenes/review_scrolls.tscn").instantiate()
	review_scrolls.tree_exited.connect(disable_holder_scrolls.bind(false))
	get_tree().current_scene.add_child(review_scrolls)

func _on_scroll_1_pressed() -> void:
	holder_review_scrolls()

func _on_scroll_2_pressed() -> void:
	holder_review_scrolls()
