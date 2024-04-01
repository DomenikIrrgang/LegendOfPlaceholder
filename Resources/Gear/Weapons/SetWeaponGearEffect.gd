class_name SetWeaponGearEffect
extends GearEffect

@export
var weapon: PackedScene

func on_gear_equipped(_gear: Gear, _target: Unit) -> void:
	var instance = weapon.instantiate()
	Globals.get_player().set_weapon(instance)
	
func on_gear_unequipped(_gear: Gear, _target: Unit) -> void:
	Globals.get_player().set_weapon(null)
