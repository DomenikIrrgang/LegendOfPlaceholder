class_name ItemQuestReward
extends QuestReward

@export
var item: Item

@export
var amount: int = 1

func reward() -> void:
	Globals.get_inventory().add_item(item, amount)
	
func can_reward() -> bool:
	return Globals.get_inventory().can_receive_item(item, amount)
