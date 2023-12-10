class_name ResourceCrystalEffect
extends OnEquipEffect

@export
var resource: ResourceType.Enum

func on_gear_equipped(gear: Gear, target: Unit) -> void:
	target.add_resource(get_unit_resource(resource, target))
	
func on_gear_unequipped(gear: Gear, target: Unit) -> void:
	target.remove_resource(resource)

func get_unit_resource(resource_type: ResourceType.Enum, target: Unit) -> UnitResource:
	match (resource_type):
		ResourceType.Enum.MANA:
			return Mana.new(target)
		ResourceType.Enum.RAGE:
			return Rage.new(target)
		ResourceType.Enum.ENERGY:
			return Energy.new(target)
	return null
