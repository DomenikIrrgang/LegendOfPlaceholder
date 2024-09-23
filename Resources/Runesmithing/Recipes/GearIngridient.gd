class_name GearIngridient
extends DynamicIngridient

@export
var slots: Array[Gear.Slot] = []

@export
var rune_slots: Array[SpellSchool.Enum] = []

func _int() -> void:
	amount = 1

func get_possible_ingriedients_from_inventory() -> Array[ItemInstance]:
	return super().filter(is_gear_instance).filter(is_gear_slot).filter(has_rune_slot)
	
func is_gear_instance(item_instance: ItemInstance) -> bool:
	return item_instance is GearInstance
	
func is_gear_slot(gear_instance: GearInstance) -> bool:
	return slots.has(gear_instance.item.slot) or slots.size() == 0

func has_rune_slot(gear_instance: GearInstance) -> bool:
	for rune_slot in rune_slots:
		for gear_rune_slot in gear_instance.item.rune_slots:
			if gear_rune_slot.spell_school == rune_slot:
				return true
	return rune_slots.size() == 0
