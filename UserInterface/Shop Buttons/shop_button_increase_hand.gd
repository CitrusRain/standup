extends ShopButton

# Called when the node enters the scene tree for the first time.
func ready2() -> void:
	cost = 5.0
	cost = pow(cost, float(GlobalData.max_hand_size)) ## Simple exponential upgrade cost
	$Sprite2D/Label.text = str(cost)

func run_action() -> void:
	GlobalData.max_hand_size += 1
	$Button.disabled = true
