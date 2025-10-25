extends Node2D

@onready var joke_file = ClydeDialogue.new()
@onready var joke_node = Card
@export var dialogue_holder : PackedScene ##The object that is to be spawned
@onready var stage_dialogue_box: Control = get_tree().get_first_node_in_group("StageSpeechBox")
@onready var ui: Control = get_tree().get_first_node_in_group("UI")

signal punchline

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_user_signal("punchline", [
		{ "name": "basepoints", "type": TYPE_INT },
		{ "name": "jokedata", "type": TYPE_ARRAY }
	])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func show_next_line(reading_card: Card = joke_node) -> void:
	joke_node = reading_card
	var speechbox = dialogue_holder.instantiate()
	var idk = joke_file.get_content()
	ui.next_visible(idk.get("type") != "end") #sets visibility of next line button
	if idk.get("type") != "end":
		print(idk.get("speaker"))
		if idk.get("speaker") == null:
			speechbox.set_text(idk.get("text"))
		elif idk.get("speaker") == "Punchline":
			emit_signal("punchline", joke_node.data)
			speechbox.set_text(idk.get("text"))
		elif idk.get("speaker") == "Self-Destruct":
			joke_node.delete_self()
			ui.next_visible(false)
		else:
			speechbox.set_text(str(idk.get("speaker"), ": " , idk.get("text")))
	else:
		joke_node.uses += 1 ##Finished telling the joke one more time than before
		print("eof")
	for lines in stage_dialogue_box.get_children():
		lines.queue_free()
	stage_dialogue_box.add_child(speechbox)
