class_name CollectItemQuestObjective
extends QuestObjective

@export
var item: Item

@export
var amount: int = 1

func is_completed() -> bool:
	return Globals.get_inventory().has_item_amount(item, amount)
	
func get_progess_string() -> String:
	return str(min(Globals.get_inventory().get_item_amount(item), amount)) + "/" + str(amount) + " " + item.alias
