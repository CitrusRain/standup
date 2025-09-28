extends Node2D
class_name Person

var gender : String
var career : String
var age_group : String

var positives : Array[String]
var negatives : Array[String]

@onready var personality_info: Panel = $PersonalityInfo

@onready var laugh_timeout: Timer = $LaughTimeout
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@onready var lbl_asl: Label = $PersonalityInfo/VBoxContainer/lbl_asl
@onready var lbl_profession: Label = $PersonalityInfo/VBoxContainer/lbl_profession
@onready var lbl_positive: Label = $PersonalityInfo/VBoxContainer/lbl_positive
@onready var lbl_negative: Label = $PersonalityInfo/VBoxContainer/lbl_negative

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
	var callable = Callable(self, "laugh")
	batman.connect("punchline",  callable)
	if get_parent().scale.x < 0:
		personality_info.scale.x = -1 * personality_info.scale.x
	if get_parent().scale.y < 0:
		personality_info.scale.y = -1 * personality_info.scale.y

func _process(_delta: float) -> void:
	personality_info.global_position.x = get_global_mouse_position().x + 10
	personality_info.global_position.y = get_global_mouse_position().y + 10
	

func laugh() -> void:
	$LaughterParticle.emitting = true
	laugh_timeout.wait_time = randf_range(0.5, 3.0)
	laugh_timeout.start()


func _on_laugh_timeout_timeout() -> void:
	$LaughterParticle.emitting = false

func _on_area_2d_mouse_entered() -> void:
	print("ALERT RED SPY IS IN THE BASE")
	personality_info.visible = true


func _on_area_2d_mouse_exited() -> void:
	personality_info.visible = false
	pass # Replace with function body.

func update_labels() -> void:
	lbl_asl.text = str(age_group , ", ", gender)
	lbl_profession.text = str(career)
	var not_first = false
	for p in positives:
		if not_first:
			lbl_positive.text += ", "
		lbl_positive.text += p
		not_first = true
	not_first = false
	for n in negatives:
		if not_first:
			lbl_negative.text += ", "
		lbl_negative.text += n
		not_first = true
