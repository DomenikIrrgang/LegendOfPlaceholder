class_name GearSet
extends Resource

@export
var alias: String = ""

@export
var set_pieces: Array[Equipment.Enum] = []

@export
var set_bonuses: Array[SetBonus] = []

func get_completed_bonuses() -> Array[SetBonus]:
	var result: Array[SetBonus] = []
	for bonus in set_bonuses:
		if is_bonus_completed(bonus):
			result.append(bonus)
	return result
		
func is_bonus_completed(bonus) -> bool:
	return set_bonuses.has(bonus) and bonus.required_pieces <= get_number_of_set_pieces()
	
func get_set_bonuses() -> Array[SetBonus]:
	return set_bonuses
	
func get_number_of_set_pieces() -> int:
	var result = 0
	for set_piece in set_pieces:
		if not Globals.get_player().has_gear_equipped(Equipment.get_gear_data(set_piece)):
			result += 1
	return result
