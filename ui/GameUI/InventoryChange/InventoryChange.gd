class_name InventoryChange
extends VBoxContainer

var InventoryChangeItemComponent = preload("res://ui/GameUI/InventoryChange/InventoryChangeItem.tscn")

func _ready() -> void:
	Globals.get_inventory().received_item.connect(on_item_received)
	
func on_item_received(item: Item, amount: int) -> void:
	var list_item = InventoryChangeItemComponent.instantiate()
	add_child(list_item)
	list_item.set_change(item, amount)
