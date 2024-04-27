class_name QuestPrompt
extends CenterContainer

var test_quest: Quest = preload("res://Resources/Quests/DangerInTheWoods.tres")

@onready
var quest_name: Label = $VBoxContainer/ScrollMiddle/Margin/Spacing/QuestInfo/QuestName

@onready
var quest_descirption: Label = $VBoxContainer/ScrollMiddle/Margin/Spacing/QuestInfo/QuestDescription

@onready
var rewards: Container = $VBoxContainer/ScrollMiddle/Margin/Spacing/QuestInfo/RewardsContainer/HFlowContainer

var RewardPanel = preload("res://ui/GameUI/Questlog/RewardPanel.tscn")

func _ready():
	prompt_quest(test_quest)

func prompt_quest(quest: Quest) -> void:
	quest_name.text = quest.name
	quest_descirption.text = quest.description + quest.description + quest.description + quest.description + quest.description + quest.description + quest.description
	for child in rewards.get_children():
		child.queue_free()
	for reward in quest.rewards:
		if reward is ItemQuestReward:
			var reward_panel = RewardPanel.instantiate()
			rewards.add_child(reward_panel)
			reward_panel.set_reward(reward.item, reward.amount)
