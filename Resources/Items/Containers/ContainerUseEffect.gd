class_name ContainerUseEffect
extends UseEffect

@export
var loot_table: Array[LootDrop] 

class ItemAssignment:
	var item: Item
	var amount: int
	
	func _init(_item: Item, _amount: int) -> void:
		item = _item
		amount = _amount

func on_use(_source: Unit) -> bool:
	var loot: Array[ItemAssignment] = []
	for loot_drop in loot_table:
		var drop_chance = loot_drop.chance
		var roll = Globals.random_value(0.0, 1.0)
		if drop_chance >= roll:
			var amount = int(round(loot_drop.minimum_amount + (loot_drop.maximum_amount - loot_drop.minimum_amount) * Globals.random_value(0.0, 1.0)))
			loot.append(ItemAssignment.new(loot_drop.item, amount))
	var slots_needed = 0
	for item_assignment in loot:
		slots_needed += Globals.get_inventory().get_slots_needed_for_item_amount(item_assignment.item, item_assignment.amount)
	if slots_needed <= Globals.get_inventory().get_free_slot_amount():
		for item_assignment in loot:
			assert(Globals.get_inventory().add_item(item_assignment.item, item_assignment.amount), "Failed to add loot from container to inventory.")
		return true
	return false
