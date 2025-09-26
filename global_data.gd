extends Control

var new_player = true
var selected_card_in_menu : Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func cache_new_card(new_card: Card, in_hand: bool = false) -> void:
	var copied_card = copy_card(new_card)
	if in_hand:
		$Equipped.add_child(copied_card)
	$Inventory.add_child(copied_card)

func get_inventory() -> Array:
	return $Inventory.get_children()

func get_equipped() -> Array:
	return $Equipped.get_children()

func copy_card(original: Card) -> Card:
	var new_card = original.duplicate()
	new_card.visible_text = original.visible_text
	new_card.filename = original.filename
	new_card.uses = original.uses
	return new_card

func copy_card_to_inventory(original: Card) -> void:
	var new_card = original.duplicate()
	new_card.visible_text = original.visible_text
	new_card.filename = original.filename
	new_card.uses = original.uses
	new_card.reparent($Inventory)

func copy_card_to_equipped(original: Card) -> void:
	var new_card = original.duplicate()
	new_card.visible_text = original.visible_text
	new_card.filename = original.filename
	new_card.uses = original.uses
	new_card.reparent($Equipped)

func wipe_equipped() -> void:
	for child in $Equipped.get_children():
		child.queue_free()
