class_name Inventory
extends Node

class InventorySlot:
	var item: Item
	var amount: int
	
	func _init(_item: Item, _amount: int):
		item = _item
		amount = _amount

var size: int
var slots: Array[InventorySlot] = []

signal received_item(item: Item, amount: int)
signal removed_item(item: Item, amount: int)
signal slot_changed(slot: int, item: Item, amount: int)
signal swapped_item(slot1: int, slot2: int)

func _init(_size: int = 32):
	size = _size
	slots.resize(size)
	for i in size:
		slots[i] = InventorySlot.new(null, 0)

func can_receive_item(item: Item, amount: int) -> bool:
	return calculate_free_amount_for_item(item) >= amount
	
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
		if slots[i].item == item:
			amount += 1
	return amount
	
func get_free_slot_amount() -> int:
	var amount = 0
	for i in size:
		if slots[i].item == null:
			amount += 1
	return amount
	
func get_item_amount(item: Item) -> int:
	var amount: int = 0
	for i in size:
		if slots[i].item == item:
			amount += slots[i].amount
	return amount
	
func change_slot(slot: int, item: Item, amount: int) -> void:
	slots[slot].item = item
	slots[slot].amount = amount
	slot_changed.emit(slot, item, amount)
	
func contains_item(item: Item) -> bool:
	return find_item(item) != -1 
	
func find_item(item: Item) -> int:
	for i in size:
		if item == slots[i].item:
			return i
	return -1
	
func find_first_empty_slot() -> int:
	for i in size:
		if slots[i].item == null:
			return i
	return -1
	
func add_item(item: Item, amount: int) -> bool:
	if amount > 0:
		if can_receive_item(item, amount):
			# First fill up existing stacks
			if item.stackable == true:
				for i in size:
					if amount > 0 and slots[i].item == item and item.stack_amount > slots[i].amount:
						var amount_to_add = item.stack_amount - slots[i].amount if amount >= item.stack_amount - slots[i].amount else amount
						change_slot(i, item, slots[i].amount + amount_to_add)
						amount -= amount_to_add
					if amount == 0:
						break
			# Generate new stacks for the remaining amount
			for i in size:
				if slots[i].item == null:
					var amount_to_add = item.stack_amount - slots[i].amount if amount >= item.stack_amount - slots[i].amount else amount
					change_slot(i, item, slots[i].amount + amount_to_add)
					amount -= amount_to_add
				if amount == 0:
						break
			return true
	else:
		return true
	return false

func split_item(slot1: int, slot2: int, amount1: int, amount2: int) -> bool:
	return true

func swap_slots(slot1: int, slot2: int) -> bool:
	if slot1 >= 0 and slot1 < size and slot2 >= 0 and slot2 < size and slot1 != slot2:
		var tmp_slot = InventorySlot.new(slots[slot2].item, slots[slot2].amount)
		change_slot(slot2, slots[slot1].item, slots[slot1].amount)
		change_slot(slot1, tmp_slot.item, tmp_slot.amount)
		return true
	return false

func get_size() -> int:
	return size