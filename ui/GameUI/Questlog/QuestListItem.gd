class_name QuestListItem
extends PanelContainer

@onready
var titel: Label = $MarginContainer/Name

@onready
var background: ColorRect =  $BackgroundColor

var quest: Quest

func _ready() -> void:
	unselect()

func set_quest(_quest: Quest) -> void:
	quest = _quest
	titel.text = "[" + str(quest.recommended_level) + "] " + quest.name

func select() -> void:
	background.visible = true
	
func unselect() -> void:
	background.visible = false
	
func is_selected() -> bool:
	return background.visible
