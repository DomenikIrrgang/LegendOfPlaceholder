extends ScrollContainer

@onready
var titel: Label = $MarginContainer/QuestDescription/Titel

@onready
var description: Label = $MarginContainer/QuestDescription/DescirptionContainer/Description

@onready
var objectives: Label = $MarginContainer/QuestDescription/ObjectivesContainer/VBoxContainer/Objective

@onready
var rewards: FlowContainer = $MarginContainer/QuestDescription/RewardsContainer/Rewards

@onready
var objecives_container: VBoxContainer = $MarginContainer/QuestDescription/ObjectivesContainer

var RewardPanel = preload("res://ui/GameUI/Questlog/RewardPanel.tscn")

func set_quest(quest: Quest) -> void:
	titel.text = quest.name
	description.text = quest.description
	for child in rewards.get_children():
		child.queue_free()
	for reward in quest.rewards:
		if reward is ItemQuestReward:
			var reward_panel = RewardPanel.instantiate()
			rewards.add_child(reward_panel)
			reward_panel.set_reward(reward.item, reward.amount)
	if quest.objectives.size() > 0:
		objecives_container.visible = true
		objectives.text = ""
		for objective in quest.objectives:
			objectives.text += objective.get_progess_string() + "\n"
	else:
		objecives_container.visible = false
