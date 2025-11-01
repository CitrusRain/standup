extends Control
@onready var tab_container: TabContainer = $TabContainer

@onready var tab_manage_routine: Panel = $"TabContainer/Manage Routine"
@onready var joke_inventory: GridContainer = $"TabContainer/Manage Routine/SplitContainer/Joke Inventory/VBoxContainer/GridContainer"
@onready var equipped: GridContainer = $"TabContainer/Manage Routine/SplitContainer/Equipped/VBoxContainer/GridContainer"

@export var card_frame : PackedScene

enum  tab_names { 
					LEVEL , ## Venue select Tab
					EQUIP ,   ## Manage Routine Tab
					SHOP    ## Writer's room Tab
					}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalData.new_player:
		$"TabContainer/Writer's Room/BeginnerPanel".visible = true
		$"TabContainer/Writer's Room/PanelContainer".visible = false
	reload_cards()

func reload_cards() -> void: ##Load the inventory and equipment panels
	var jokes_arr =  GlobalData.get_inventory()
	for j in jokes_arr:
		var frame = card_frame.instantiate()
		j.reparent(frame)
		j.position.x = 60
		j.position.y = 45
		j.visible = true
		joke_inventory.add_child(frame)
		#GlobalData.cache_new_card(j) # Keeping this 
	jokes_arr =  GlobalData.get_equipped()
	for j in jokes_arr:
		#var local_copy = GlobalData.copy_card(j)
		var frame = card_frame.instantiate()
		j.reparent(frame)
		#TODO: figure out how to not hardcode these values!, I have no idea why this is the correct way to have things aligned right!!!
		j.position.x = frame.global_position.x + 60
		j.position.y = 40
		equipped.add_child(frame)


func _on_venue_button_pressed() -> void:
	send_data_to_global()
	get_tree().change_scene_to_file("res://venues/main_venue.tscn")
	pass # Replace with function body.

func send_data_to_global() -> void:
	for j in joke_inventory.get_children():
		GlobalData.cache_new_card(j.get_child(0))
	for ej in equipped.get_children():
		GlobalData.cache_new_card(ej.get_child(0),true)


func _on_starter_button_pressed() -> void:
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card00"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card01"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card02"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card03"))
	GlobalData.cache_new_card(Catalog.get_node("StarterPack/Card04"))
	reload_cards()
	tab_manage_routine.visible = true
	for i in joke_inventory.get_children(): ## Forces all cards in inventory to be equipped
		i.reparent(equipped)
	$"TabContainer/Writer's Room/BeginnerPanel".visible = false
	$"TabContainer/Writer's Room/PanelContainer".visible = true
	GlobalData.new_player = false
	pass # Replace with function body.


func _on_buy_1_joke_pressed() -> void:
	var card_set = Catalog.get_child((randi()%(Catalog.get_child_count()-1))+1)
	while card_set.visible == false:
		print("set not availible")
		card_set = Catalog.get_child((randi()%(Catalog.get_child_count()-1))+1)
	GlobalData.cache_new_card(card_set.get_child(randi()%card_set.get_child_count()))
	reload_cards()
	
	tab_manage_routine.visible = true
	pass # Replace with function body.


func _on_tab_container_tab_selected(tab: int) -> void: ##If we have any code needing checked when moving tabs, such as if a popup should become visible, do here.
	if tab == tab_names.LEVEL:
		if equipped:
			$"TabContainer/Select Venue/MinEquipAlert".visible = (equipped.get_child_count() < 5)
		else:
			$"TabContainer/Select Venue/MinEquipAlert".visible = true
	elif tab == tab_names.EQUIP:
		pass
	elif tab == tab_names.SHOP:
		pass


func _on_manage_button_pressed() -> void:
	tab_container.current_tab = tab_names.EQUIP

func _on_shop_button_pressed() -> void:
	tab_container.current_tab = tab_names.SHOP


func _on_buy_set_2_pressed() -> void:
	var cardset = Catalog.get_child(2)
	if cardset.visible == false:
		print("set not availible")
		return
	for card_to_add in cardset.get_children():
		GlobalData.cache_new_card(card_to_add)
	reload_cards()
	tab_manage_routine.visible = true
	pass # Replace with function body.
