extends Node2D

@onready var hand: Node2D = $Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for j in GlobalData.get_equipped():
		j.reparent(hand)
		j.global_position.x = 0
		j.position.y = 0
		j.offset_left = 0
		j.offset_right = 0
		j.offset_top = 0
		j.offset_bottom = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
