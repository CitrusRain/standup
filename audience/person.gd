extends Node2D
class_name Person

var gender : String
var career : String
var age_group : String

var positives : Array[String]
var negatives : Array[String]
var pos_enums : Array[general_functions.humor_types]
var neg_enums : Array[general_functions.humor_types]

@onready var personality_info: Panel = $PersonalityInfo

@onready var laugh_timeout: Timer = $LaughTimeout
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@onready var lbl_asl: Label = $PersonalityInfo/VBoxContainer/lbl_asl
@onready var lbl_profession: Label = $PersonalityInfo/VBoxContainer/lbl_profession
@onready var lbl_positive: Label = $PersonalityInfo/VBoxContainer/lbl_positive
@onready var lbl_negative: Label = $PersonalityInfo/VBoxContainer/lbl_negative

var big_laugh_stack_size = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var batman: Node2D = get_tree().get_first_node_in_group("JokeHandler")
	var callable = Callable(self, "laugh")
	batman.connect("punchline",  callable)
	var callable2 = Callable(self, "set_big_laugh_bonus_particles")
	GlobalData.connect("big_laugh_bonus_particle_controler",  callable2)
	if get_parent().scale.x < 0:
		personality_info.scale.x = -1 * personality_info.scale.x
	if get_parent().scale.y < 0:
		personality_info.scale.y = -1 * personality_info.scale.y

func _process(_delta: float) -> void:
	personality_info.global_position.x = get_global_mouse_position().x + 10
	personality_info.global_position.y = get_global_mouse_position().y + 10
	if not laugh_timeout.paused and not laugh_timeout.is_stopped():
		GlobalData.add_score(1 + big_laugh_stack_size)
		$LaughSound.pitch_scale = randf_range(1.0,4.0)
		$LaughSound.play()

func set_big_laugh_bonus_particles() -> void:
	if big_laugh_stack_size > 0:
		#print("big_laugh_stack_size " , big_laugh_stack_size)
		big_laugh_stack_size -= 1
		$LaughterParticle.scale_amount_min = 2
		$LaughterParticle.scale_amount_max = 3
	else:
		$LaughterParticle.scale_amount_min = 1
		$LaughterParticle.scale_amount_max = 1.5
			
	

func laugh(args: Array) -> void:
	var taste_bonus = 1.0
	for multiplier in args:
		print("checking: " , multiplier)
		if taste_bonus != 0.0:
			for pos in pos_enums:
				if pos == multiplier:
					print("matching postive")
					taste_bonus += 50
			for neg in neg_enums:
				if neg == multiplier:
					taste_bonus *= randf_range(-5.0, 1.0)
					taste_bonus = max(taste_bonus, 0)
	var laugh_time = randf_range(0.5 * taste_bonus, 3.0 * taste_bonus)
	print("Bonus = ", taste_bonus, " XD = ", laugh_time)
	while laugh_time > 5.0: 
		laugh_time -= 5.0
		big_laugh_stack_size += 1
	if laugh_time >= 0.1:
		laugh_timeout.wait_time = laugh_time
		$LaughterParticle.emitting = true
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
	for p in pos_enums:
		if not_first:
			lbl_positive.text += ", "
		lbl_positive.text += general_functions.humor_type_strings[p]
		not_first = true
	not_first = false
	for n in neg_enums:
		if not_first:
			lbl_negative.text += ", "
		lbl_negative.text += general_functions.humor_type_strings[n]
		not_first = true
