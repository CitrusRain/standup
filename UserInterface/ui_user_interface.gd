extends Control


@onready var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
@onready var next_line: Button = $NextLine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_line_pressed() -> void:
	batman.show_next_line()
	pass # Replace with function body.

func next_visible(visible: bool = true) -> void:
	next_line.visible = visible
