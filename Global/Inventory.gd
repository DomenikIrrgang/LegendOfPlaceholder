class_name Inventory
extends Node

var size: int
var slots: Array[InventorySlot] = []

signal received_item(item: ItemInstance, amount: int)
signal removed_item(item: ItemInstance, amount: int)
signal inventory_changed(item: ItemInstance, amount: int)
signal slot_changed(slot: int, item: ItemInstance, amount: int)

func _init(_size: int = 32):
	size = _size
	slots.resize(size)
	received_item.connect(on_inventory_changed)
	removed_item.connect(on_inventory_changed)
	for i in size:
		slots[i] = InventorySlot.new(null, 0, i)
		
func on_inventory_changed(item: ItemInstance, amount: int) -> void:
	inventory_changed.emit(item, amount)

func empty() -> void:
	for slot in range(slots.size()):
		change_slot(slot, null, 0)

func can_receive_item(item: Item, amount: int) -> bool:
	return calculate_free_amount_for_item(item) >= amount
	
func get_slots_needed_for_item_amount(item: Item, amount: int) -> int:
	var amount_needed = amount
	var item_amount = get_item_amount(item)
	var existing_slots = slots_with_item(item) * (item.stack_amount if item.stackable else 1) - item_amount
	amount_needed -= existing_slots
	if amount_needed > 0:
		if item.stackable:
			return amount_needed / item.stack_amount
		else:
			return amount_needed
	return 0
	
func calculate_free_amount_for_item(item: Item) -> int:
	var item_amount = get_item_amount(item)
	var free_slots =  get_free_slot_amount() * (item.stack_amount if item.stackable else 1)
	var existing_slots = slots_with_item(item) * (item.stack_amount if item.stackable else 1) - item_amount
	var potential_amount = free_slots + existing_slots
	if item.limited:
		var remaining_limit = item.limit - item_amount
		if remaining_limit < potential_amount:
			return remaining_limit
	return potential_amount
	
func slots_with_item(item: Item) -> int:
	var amount = 0
	for i in size:
		if slots[i].item_instance != null and slots[i].item_instance.item == item:
			amount += 1
	return amount
	
func get_free_slot_amount() -> int:
	var amount = 0
	for i in size:
		if slots[i].item_instance == null:
			amount += 1
	return amount
	
func has_item_amount(item: Item, amount: int) -> bool:
	return get_item_amount(item) >= amount
	
func get_item_amount(item: Item) -> int:
	var amount: int = 0
	for i in size:
		if slots[i].item_instance != null and slots[i].item_instance.item == item:
			amount += slots[i].amount
	return amount
	
func change_slot(slot: int, item_instance: ItemInstance, amount: int) -> void:
	if amount == 0:
		slots[slot].item_instance = null
	else:
		slots[slot].item_instance = item_instance
	slots[slot].amount = amount
	if item_instance != null:
		slot_changed.emit(slot, slots[slot].item_instance, amount)
	else:
		slot_changed.emit(slot, null, amount)
	
func contains_item(item: Item) -> bool:
	return find_item(item) != -1
	
func find_item(item: Item) -> int:
	for i in size:
		if item == slots[i].item_instance.item:
			return i
	return -1
	
func use_slot(source: Unit, slot: int) -> bool:
	if slots[slot].item_instance != null and slots[slot].item_instance.item.useable and slots[slot].amount > 0:
		var success = slots[slot].item_instance.item.use_effect.use(source)
		if success:
			var item = slots[slot].item_instance
			change_slot(slot, item, slots[slot].amount - 1)
			removed_item.emit(item, 1)
			return true
	return false
	
func use_item(source: Unit, item: Item) -> bool:
	var slot: int = find_item(item)
	if slot != -1:
		return use_slot(source, slot)
	return false
	
func find_first_empty_slot() -> int:
	for i in size:
		if slots[i].item_instance == null:
			return i
	return -1
	
func add_item(item_instance: ItemInstance, amount: int) -> bool:
	if amount > 0:
		if can_receive_item(item_instance.item, amount):
			# First fill up existing stacks
			var total_amount = amount
			if item_instance.item.stackable == true:
				for i in size:
					if amount > 0 and slots[i].item_instance != null and slots[i].item_instance.item == item_instance.item and item_instance.item.stack_amount > slots[i].amount:
						var amount_to_add = item_instance.item.stack_amount - slots[i].amount if amount >= item_instance.item.stack_amount - slots[i].amount else amount
						change_slot(i, item_instance, slots[i].amount + amount_to_add)
						amount -= amount_to_add
					if amount == 0:
						break
			# Generate new stacks for the remaining amount
			if amount > 0:
				for i in size:
					if slots[i].item_instance == null:
						var stack_amount = item_instance.item.stack_amount if item_instance.item.stackable else 1
						var amount_to_add = stack_amount - slots[i].amount if amount >= stack_amount - slots[i].amount else amount
						change_slot(i, item_instance, slots[i].amount + amount_to_add)
						amount -= amount_to_add
					if amount == 0:
						break
			received_item.emit(item_instance, total_amount)
			return true
	else:
		return true
	return false
	
func remove_item(item: Item, amount: int) -> bool:
	if amount > 0 and get_item_amount(item) >= amount:
		var total_amount = amount
		var item_instance: ItemInstance
		for i in size:
			if total_amount > 0 and slots[i].item_instance != null and slots[i].item_instance.item == item:
				var amount_to_remove = slots[i].amount if total_amount >= slots[i].amount else total_amount
				change_slot(i, slots[i].item_instance, slots[i].amount - amount_to_remove)
				total_amount -= amount_to_remove
				item_instance = slots[i].item_instance
			if total_amount == 0:
				break
		removed_item.emit(item_instance, amount)
		return true
	return false

func split_item(_slot1: int, _slot2: int, _amount1: int, _amount2: int) -> bool:
	return true

func swap_slots(slot1: int, slot2: int) -> bool:
	if slot1 >= 0 and slot1 < size and slot2 >= 0 and slot2 < size and slot1 != slot2:
		var tmp_slot = InventorySlot.new(slots[slot2].item_instance, slots[slot2].amount, 0)
		change_slot(slot2, slots[slot1].item_instance, slots[slot1].amount)
		change_slot(slot1, tmp_slot.item_instance, tmp_slot.amount)
		return true
	return false

func get_size() -> int:
	return size
