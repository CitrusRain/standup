extends Node
class_name general_functions

enum  humor_types { 
					DEADPAN_HUMOR, 
					ANTI_HUMOR,
					SURREAL_HUMOR,
					SARCASM,
					SLAPSTICK_HUMOR,
					OBSERVATIONAL_HUMOR,
					META_HUMOR,
					DARK_HUMOR,
					INSULT_HUMOR,
					NULL
					}

const humor_type_strings := [ "DEADPAN_HUMOR", 
					"ANTI_HUMOR",
					"SURREAL_HUMOR",
					"SARCASM",
					"SLAPSTICK_HUMOR",
					"OBSERVATIONAL_HUMOR",
					"META_HUMOR",
					"DARK_HUMOR",
					"INSULT_HUMOR",
					""]


static func get_grandparent(n) -> Node:
	return n.get_parent().get_parent()
	
static func get_great_grandparent(n) -> Node:
	return n.get_parent().get_parent().get_parent()


#From FencerDevLog https://forum.godotengine.org/t/how-do-i-get-all-nodes-from-a-scene/49088
static func get_all_children(in_node, array := []):
	array.push_back(in_node)
	for child in in_node.get_children():
		array = get_all_children(child, array)
	return array
