extends Control


@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var next_line: Button = $NextLine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalData.score_label = $Panel/HBoxContainer/score_lbl
	pass # Replace with function body.

func _on_next_line_pressed() -> void:
	batman.show_next_line()
	pass # Replace with function body.

func next_visible(my_visible: bool = true) -> void:
	next_line.visible = my_visible


func _on_leave_button_pressed() -> void:
	get_parent().send_data_to_global()
	get_tree().change_scene_to_file("res://UserInterface/prepscreen.tscn")
