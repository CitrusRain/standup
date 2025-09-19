extends Node2D


@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var dialogue = ClydeDialogue.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_paper_pressed() -> void:
	batman.joke_file.load_dialogue(str("res://DialogueSystem/Jokes/" , str(get_meta("ClydeFile"),".clyde")))
	batman.show_next_line()
