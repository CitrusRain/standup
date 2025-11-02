class_name shop_stock
extends Control

@export var shop_button_increase_hand : PackedScene = load("res://UserInterface/Shop Buttons/shop_button_increase_hand.tscn") ##The object that is to be spawned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_skill_items(quantity: int = 1) -> Array [PackedScene]:
	var shelf_items : Array[PackedScene]
	while quantity > 0:
		shelf_items.push_back(shop_button_increase_hand)
		quantity -= 1
	return shelf_items
