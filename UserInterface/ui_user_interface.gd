extends Control


@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var deck: Control = get_tree().get_first_node_in_group("Deck")
@onready var next_line: Button = $NextLine
@onready var card_picker: HBoxContainer = $CardPicker/CurrentHand
@onready var stage_dialogue: HBoxContainer = $StageDialogue

@export var card_frame : PackedScene

##The following are affected by shop items
@onready var current_hand: Control = $CardPicker/CurrentHand


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalData.score_label = $Panel/HBoxContainer/score_lbl
	pass # Replace with function body.

func _on_next_line_pressed() -> void:
	batman.show_next_line()

func next_visible(my_visible: bool = true) -> void:
	next_line.visible = my_visible
	card_picker.visible = not my_visible
	stage_dialogue.visible = my_visible
	$CardPicker/DrawButtonPanel.visible = (deck.get_child_count() > 0)


func _on_leave_button_pressed() -> void:
	get_parent().send_data_to_global()
	get_tree().change_scene_to_file("res://UserInterface/prepscreen.tscn")


func _on_draw_card_pressed() -> void:
	draw_card(0)

func _on_draw_card_randomly() -> void:
	draw_card(randi_range(0, deck.get_child_count()-1))

func _on_draw_card_bottom() -> void:
	draw_card(deck.get_child_count()-1)

func draw_card(Card_position: int) -> void: ## Draws a card from the given position; make sure index is valid before calling
	if current_hand.get_child_count() < GlobalData.max_hand_size:
		if deck.get_child_count() > 0:
			var j = deck.get_child(Card_position)
			var frame = card_frame.instantiate()
			j.reparent(frame)
			j.position.x = 60
			j.position.y = 45
			j.visible = true
			current_hand.add_child(frame)
		$CardPicker/DrawButtonPanel.visible = (deck.get_child_count() > 0)
