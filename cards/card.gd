extends Control
class_name Card

@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var dialogue = ClydeDialogue.new()
@onready var uses := 0 ## The number of times this joke has been told

@export var filename : String
@export var visible_text : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_paper_pressed() -> void:
	if get_parent().get_name() == "Hand":
		if not batman:
			batman = get_tree().get_first_node_in_group("JokeHandler")
		batman.joke_file.load_dialogue(str("res://DialogueSystem/Jokes/" , str(filename,".clyde")))
		batman.joke_node = self
		batman.show_next_line()
	elif get_parent().get_parent().get_name() == "GridContainer":
		if GlobalData.selected_card_in_menu == self: ## If already selected, move card
			var inv =   $"../../../../../Joke Inventory/VBoxContainer/GridContainer"
			var equip = $"../../../../../Equipped/VBoxContainer/GridContainer"
			print(inv, "<inv | get great grandparent>" , get_parent().get_parent().get_parent().get_parent().get_name())
			if general_functions.get_great_grandparent(self).get_parent().get_name() == "Joke Inventory":
				get_parent().reparent(equip)
			elif general_functions.get_great_grandparent(self).get_parent().get_name() == "Equipped":
				get_parent().reparent(inv)
			
		else: #load card info
			GlobalData.selected_card_in_menu = self
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
					joketext = str( joketext, "\n" , str(idk.get("speaker"), ": " , idk.get("text")))
				idk = joke_file.get_content()
			readme.find_child("Joke").text = joketext
		
		
