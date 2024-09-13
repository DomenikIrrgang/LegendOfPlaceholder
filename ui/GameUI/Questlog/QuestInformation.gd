extends ScrollContainer

@onready
var titel: Label = $MarginContainer/VBoxContainer/VBoxContainer/ScrollContainer/QuestDescription/Titel

@onready
var description: Label = $MarginContainer/VBoxContainer/VBoxContainer/ScrollContainer/QuestDescription/DescirptionContainer/Description

@onready
var objectives: Label = $MarginContainer/VBoxContainer/VBoxContainer/ScrollContainer/QuestDescription/ObjectivesContainer/ObjectivesLabel

@onready
var rewards: FlowContainer = $MarginContainer/VBoxContainer/VBoxContainer/ScrollContainer/QuestDescription/RewardsContainer/Rewards

@onready
var objecives_container: VBoxContainer = $MarginContainer/VBoxContainer/VBoxContainer/ScrollContainer/QuestDescription/ObjectivesContainer/VBoxContainer

var RewardPanel = preload("res://ui/GameUI/Questlog/RewardPanel.tscn")

var quest: Quest = null

func set_quest(_quest: Quest) -> void:
	quest = _quest
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


func _on_abandon_quest_button_pressed() -> void:
	QuestManager.abandon_quest(quest)
