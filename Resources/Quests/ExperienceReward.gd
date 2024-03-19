class_name ExperienceReward
extends QuestReward

@export
var amount: int = 0

func reward() -> void:
	Globals.get_player().gain_experience(amount)
