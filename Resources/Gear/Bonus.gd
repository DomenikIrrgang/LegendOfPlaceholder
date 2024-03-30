class_name Bonus
extends Resource

@export
var description: String = ""

@export
var required_pieces: int = 2

@export
var gear_effects: Array[GearEffect] = []

func on_bonus_active(_gear: Gear, _target: Unit) -> void:
	for gear_effect in gear_effects:
		gear_effect.on_gear_equipped(_gear, _target)
	
func on_bonus_inactive(_gear: Gear, _target: Unit) -> void:
	for gear_effect in gear_effects:
		gear_effect.on_gear_unequipped(_gear, _target)
