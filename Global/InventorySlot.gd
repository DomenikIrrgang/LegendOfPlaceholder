class_name InventorySlot
extends Node

var item_instance: ItemInstance
var amount: int
var index: int

func _init(_item_instance: ItemInstance, _amount: int, _index: int):
	item_instance = _item_instance
	amount = _amount
	index = _index
