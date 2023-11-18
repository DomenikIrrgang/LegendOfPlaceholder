class_name InventorySlot
extends Node

var item: Item
var amount: int
var index: int

func _init(_item: Item, _amount: int, _index: int):
	item = _item
	amount = _amount
	index = _index
