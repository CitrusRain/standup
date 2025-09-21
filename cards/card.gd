extends Control
class_name Card

@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var dialogue = ClydeDialogue.new()
@onready var uses := 0 ## The number of times this joke has been told

@export var filename : String
@export var visible_text : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if filename == "":
		filename = get_meta("ClydeFile")
	if visible_text == "":
		visible_text = get_meta("CardText")
	pass # Replace with function body.

func _on_paper_pressed() -> void:
	if get_parent().get_name() == "Hand":
		batman.joke_file.load_dialogue(str("res://DialogueSystem/Jokes/" , str(filename,".clyde")))
		batman.joke_node = self
		batman.show_next_line()
	elif get_parent().get_parent().get_name() == "GridContainer":
		var readme = get_tree().get_first_node_in_group("JokeInfoBox")
		readme.find_child("JokeNumber").text = "NaN"
		
		#Read joke to show in side panel
		readme.find_child("PunchlineHider").folded = true
		var joke_file = ClydeDialogue.new()
		joke_file.load_dialogue(str("res://DialogueSystem/Jokes/" , str(filename,".clyde")))
		var joketext = ""
		var idk = joke_file.get_content()
		while idk.get("type") != "end":
			if idk.get("speaker") == null:
				joketext = str( joketext , "\n", idk.get("text"))
			elif idk.get("speaker") == "Punchline":
				readme.find_child("Punchline").text = idk.get("text")
			else:
				print( idk.get("speaker") )
				joketext = str( joketext , str(idk.get("speaker"), ": " , idk.get("text")))
			idk = joke_file.get_content()
		readme.find_child("Joke").text = joketext
		
		
