extends Node2D

var career : String


@onready var laugh_timeout: Timer = $LaughTimeout


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
	var callable = Callable(self, "laugh")
	batman.connect("punchline",  callable)


func laugh() -> void:
	$LaughterParticle.emitting = true
	laugh_timeout.wait_time = randf_range(0.5, 3.0)
	laugh_timeout.start()


func _on_laugh_timeout_timeout() -> void:
	$LaughterParticle.emitting = false
