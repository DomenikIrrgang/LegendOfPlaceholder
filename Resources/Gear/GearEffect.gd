class_name GearEffect
extends Resource

var description: String : get = get_description

func on_gear_equipped(_gear: Gear, _target: Unit) -> void:
	pass
	
func on_gear_unequipped(_gear: Gear, _target: Unit) -> void:
	pass
	
func get_description() -> String:
	return "GearEffect" + get_class()
