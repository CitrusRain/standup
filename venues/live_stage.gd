extends Node2D

@export var gender_table: Array[Array] = [
	["male",50],
	["female",47],
	["non-binary",2],
	["transgender",1]
]

@export var profession_table: Array[Array] = [
	["contractor",10],
	["food service",39],
	["customer support",3],
	["retail",20],
	["accountant",15],
	["public service",10],
	["teacher",2],
	["doctor",1]
]

@export var age_table: Array[Array] = [
	["teen",10],
	["young adult",47],
	["adult",40],
	["middle-age",2],
	["senior",1]
]

@export var humor_type_table: Array[Array] = [
	[general_functions.humor_types.DEADPAN_HUMOR, "Deadpan",11], 
	[general_functions.humor_types.ANTI_HUMOR, "Anti-Humor",11],
	[general_functions.humor_types.SURREAL_HUMOR, "Surreal Humor",11],
	[general_functions.humor_types.SARCASM, "Sarcasm",11],
	[general_functions.humor_types.SLAPSTICK_HUMOR, "Slapstick",11],
	[general_functions.humor_types.OBSERVATIONAL_HUMOR, "Observational",11],
	[general_functions.humor_types.META_HUMOR, "Meta Humor",11],
	[general_functions.humor_types.DARK_HUMOR, "Dark comedy",11],
	[general_functions.humor_types.INSULT_HUMOR, "Insults",11],
	[-1, "None",1]
]

@export var base_person : Array[PackedScene]

#@export var chair_count : int = 4
@export var chance_of_empty_seat : float = 1

@export var likes_per_person : int = 2
@export var dislikes_per_person : int = 1

@onready var hand: Node2D = $Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for j in GlobalData.get_equipped(): ##load hand
		j.reparent(hand)
		j.global_position.x = 0
		j.position.y = 0
		j.offset_left = 0
		j.offset_right = 0
		j.offset_top = 0
		j.offset_bottom = 0
		
	## Generate crowd
	var seat_fill_roll = 100.0
	for seat in $Scenery.get_children():
		if seat is Chair and seat_fill_roll > chance_of_empty_seat:
			seat_fill_roll = randf_range(0, 100)
			var new_person = base_person[(randi() % base_person.size())-1].instantiate()
			var r_num : int
			##Determine Gender
			r_num = randi_range(1,100)
			for g in gender_table:
				r_num -= g[1]
				if r_num <= 0:
					new_person.gender = g[0]
					break
			##Determine career
			r_num = randi_range(1,100)
			for c in profession_table:
				r_num -= c[1]
				if r_num <= 0:
					new_person.career = c[0]
					break
			##Determine age group
			r_num = randi_range(1,100)
			for a in age_table:
				r_num -= a[1]
				if r_num <= 0:
					new_person.age_group = a[0]
					break
			new_person.position.y = -35
			##Determine bonuses
			for do_more in likes_per_person:
				r_num = randi_range(1,100)
				for b in humor_type_table:
					r_num -= b[2]
					if r_num <= 0:
						var is_already_picked = false
						for p in new_person.positives:
							if b[1] == p:
								is_already_picked = true
								print("found duplicate pos")
						if not is_already_picked and b[1] != "None":
							#new_person.positives.append(b[1])
							new_person.pos_enums.append(b[0])
						break
			##Determine penalties
			for do_more in dislikes_per_person:
				r_num = randi_range(1,100)
				for b in humor_type_table:
					r_num -= b[2]
					if r_num <= 0:
						var is_already_picked = false
						for n in new_person.negatives:
							if b[1] == n:
								is_already_picked = true
								print("found duplicate negative")
								
						var array_pos = 0
						for p in new_person.positives:
							if b[1] == p:
								is_already_picked = true
								new_person.positives.remove_at(array_pos)
							array_pos += 1
						if not is_already_picked and b[1] != "None":
							#new_person.negatives.append(b[1])
							new_person.neg_enums.append(b[0])
						break
			new_person.position.y = -35
			new_person.z_index = 3
			new_person.modulate = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1)) 
			seat.add_child(new_person)
			new_person.update_labels()


func send_data_to_global() -> void:
	for ej in hand.get_children():
		print(ej)
		ej.reparent(GlobalData.get_child(1))
		ej.global_position.x = 0
		ej.position.y = 0
		ej.offset_left = 0
		ej.offset_right = 0
		ej.offset_top = 0
		ej.offset_bottom = 0
	#print("data is in global")
