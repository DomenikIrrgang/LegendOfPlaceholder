class_name AbilityGearEffect
extends OnEquipEffect

@export
var ability: PackedScene

var instance: Ability

func on_gear_equipped(_gear: GearInstance, _target: Unit) -> void:
	instance = ability.instantiate()
	Spellbook.learn_ability(instance)
	
func on_gear_unequipped(_gear: GearInstance, _target: Unit) -> void:
	Spellbook.unlearn_ability(instance)

func get_description() -> String:
	return "Teaches you an ability."
