class_name AbilityTooltip
extends Control

@onready
var alias: Label = $PanelContainer/Content/TopLine/AbilityName/Label

@onready
var spell_school: Label = $PanelContainer/Content/TopLine/SpellSchool/Label

@onready
var cost: Label = $PanelContainer/Content/Resource/ResourceCost/Label

@onready
var resource_type: Label = $PanelContainer/Content/Resource/ResourceUnit/Label

@onready
var description: Label = $PanelContainer/Content/Description/Text/Label

func _process(_delta: float):
	visible = true
	global_position = get_viewport().get_mouse_position()
	if global_position.x >= get_viewport().size.x / 2:
		global_position.x -= size.x
	if global_position.y >= get_viewport().size.y / 2:
		global_position.y -= size.y


func show_ability(ability: Ability) -> void:
	alias.text = ability.get_alias()
	spell_school.text = SpellSchool.Enum.keys()[ability.get_spell_school()].capitalize()
	cost.text = str(ability.get_resource_cost())
	resource_type.text = ResourceType.Enum.keys()[ability.get_resource_type()].capitalize()
	description.text = ability.get_tooltip()
	
