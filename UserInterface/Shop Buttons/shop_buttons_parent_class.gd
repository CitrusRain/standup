@abstract class_name ShopButton
extends PanelContainer

var cost = 0.0
signal refresh_money

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cost = cost
	$Sprite2D/Label.text = str(cost)
	add_user_signal("refresh_money")
	ready2()

@abstract func ready2() -> void

func _on_button_pressed() -> void:
	if GlobalData.cash > cost:
		GlobalData.cash -= cost
		run_action()
	emit_signal("refresh_money")
	get_tree().get_first_node_in_group("MoneyLabel").text = str(GlobalData.cash)

@abstract func run_action() -> void
