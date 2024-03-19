class_name CollectItemQuestObjective
extends QuestObjective

@export
var item: Item

@export
var amount: int = 1

func init() -> void:
	Globals.get_inventory().received_item.connect(on_inventory_updated)
	Globals.get_inventory().removed_item.connect(on_inventory_updated)
	
func reset() -> void:
	Globals.get_inventory().received_item.disconnect(on_inventory_updated)
	Globals.get_inventory().removed_item.disconnect(on_inventory_updated)

func on_inventory_updated(_item: Item, amount: int) -> void:
	if item == _item:
		objective_progress_changed.emit(self)
		
func quest_complete() -> void:
	if is_completed():
		reset()
		Globals.get_inventory().remove_item(item, amount)

func is_completed() -> bool:
	return Globals.get_inventory().has_item_amount(item, amount)
	
func get_progess_string() -> String:
	return str(min(Globals.get_inventory().get_item_amount(item), amount)) + "/" + str(amount) + " " + item.alias
