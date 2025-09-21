extends Control

@onready var tab_manage_routine: Panel = $"TabContainer/Manage Routine"
@onready var joke_inventory: GridContainer = $"TabContainer/Manage Routine/SplitContainer/Joke Inventory/GridContainer"
@onready var equipped: GridContainer = $"TabContainer/Manage Routine/SplitContainer/Equipped/GridContainer"

@export var card_frame : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload_cards()

func reload_cards() -> void:
	##Load the inventory and equipment panels
	var jokes_arr =  GlobalData.get_inventory()
	for j in jokes_arr:
		var frame = card_frame.instantiate()
		j.reparent(frame)
		j.position.x = 60
		j.position.y = 45
		joke_inventory.add_child(frame)
	jokes_arr =  GlobalData.get_equipped()
	for j in jokes_arr:
		var frame = card_frame.instantiate()
		j.reparent(frame)
		joke_inventory.add_child(frame)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_venue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://venues/main_venue.tscn")
	pass # Replace with function body.


func _on_starter_button_pressed() -> void:
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card00"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card01"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card02"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card03"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card04"))
	reload_cards()
	$"TabContainer/Writer's Room/BeginnerPanel".visible = false
	tab_manage_routine.visible = true
	pass # Replace with function body.
