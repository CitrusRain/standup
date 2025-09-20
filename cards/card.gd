extends Control
class_name Card

@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var dialogue = ClydeDialogue.new()
@onready var uses := 0 ## The number of times this joke has been told

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_paper_pressed() -> void:
	if get_parent().get_name() == "Hand":
		batman.joke_file.load_dialogue(str("res://DialogueSystem/Jokes/" , str(get_meta("ClydeFile"),".clyde")))
		batman.joke_node = self
		batman.show_next_line()
