extends Control

var new_player = true
var selected_card_in_menu : Card

@onready var score : int = 0
@onready var cash : float = 0.00
@onready var score_label = Label

signal big_laugh_bonus_particle_controler

func _ready() -> void:
	add_user_signal("big_laugh_bonus_particle_controler")

func cache_new_card(new_card: Card, in_hand: bool = false) -> void: ##Adds card to Equipped or Inventory
	var copied_card = copy_card(new_card)
	if in_hand:
		#$Inventory.add_child(copied_card)
		$Equipped.add_child(copied_card)
	else:
		$Inventory.add_child(copied_card)
		

func get_inventory() -> Array:
	return $Inventory.get_children()

func get_equipped() -> Array:
	return $Equipped.get_children()

func copy_card(original: Card) -> Card:
	if(original):
		var new_card = original.duplicate()
		new_card.dialogue = original.dialogue
		if(original.batman):
			new_card.batman = original.batman
		new_card.visible_text = original.visible_text
		new_card.filename = original.filename
		new_card.uses = original.uses
		return new_card
	else:
		return null

func copy_card_to_inventory(original: Card) -> void:
	var new_card = original.duplicate()
	new_card.dialogue = original.dialogue
	new_card.batman = original.batman
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

func add_score(new_points: int) -> int:
	score += new_points
	score_label.text = str(score)
	return score


func _one_second_timer_timeout() -> void:
	emit_signal("big_laugh_bonus_particle_controler")
	pass # Replace with function body.
