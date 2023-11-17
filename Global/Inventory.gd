class_name Inventory
extends Node

var size: int = 24
var slots = []

signal received_item(item, amount: int)
signal removed_item(item, amount: int)
signal swapped_item(slot1: int, slot2: int)

func can_receive_item(item, amount) -> bool:
	return true
	
func add_item(item, amount) -> bool:
	return can_receive_item(item, amount)

func split_item(slot1: int, slot2: int, amount1: int, amount2: int) -> bool:
	return true

func swap_item(slot1, slot2) -> bool:
	return true

func get_size() -> int:
	return size
