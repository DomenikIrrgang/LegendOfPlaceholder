class_name AbilityTooltip
extends Control

@onready
var alias: Label = $PanelContainer/Content/TopLine/AbilityName/Label

@onready
var spell_school: Label = $PanelContainer/Content/TopLine/SpellSchool/Label

@onready
var cost: Label = $PanelContainer/Content/VBoxContainer/Resource/ResourceCost/Label

@onready
var resource_cost: Container = $PanelContainer/Content/VBoxContainer/Resource

@onready
var resource_type: Label = $PanelContainer/Content/VBoxContainer/Resource/ResourceUnit/Label

@onready
var description: Label = $PanelContainer/Content/VBoxContainer/Description/Text/Label

func _process(_delta: float):
	visible = !Globals.get_drag_and_drop().is_dragging()
	global_position = get_viewport().get_mouse_position()
	if global_position.x >= get_viewport().size.x / 2:
		global_position.x -= size.x - 1
	else:
		global_position.x += 1
	if global_position.y >= get_viewport().size.y / 2:
		global_position.y -= size.y - 1
	else:
		global_position.y += 1


func show_ability(ability: Ability) -> void:
	alias.text = ability.get_alias()
	spell_school.text = SpellSchool.Enum.keys()[ability.get_spell_school()].capitalize()
	cost.text = str(ability.get_resource_cost())
	resource_cost.visible = ability.get_resource_type() != ResourceType.Enum.FREE and ability.get_resource_type() != ResourceType.Enum.DASH_CHARGE and ability.get_resource_cost() != 0
	resource_type.text = ResourceType.Enum.keys()[ability.get_resource_type()].capitalize()
	description.text = ability.get_tooltip()
	
