class_name ItemTooltip
extends Control

@onready
var alias: Label = $MarginContainer/VBoxContainer/Alias

@onready
var cooldown: Label = $MarginContainer/VBoxContainer/Cooldown

@onready
var use_description: Label = $MarginContainer/VBoxContainer/UseDescripton

@onready
var description: Label = $MarginContainer/VBoxContainer/Description

@onready
var limit: Label = $MarginContainer/VBoxContainer/Limit

func _process(delta):
	visible = true
	global_position = get_viewport().get_mouse_position()
	if global_position.x >= get_viewport().size.x / 2:
		global_position.x -= size.x
	if global_position.y >= get_viewport().size.y / 2:
		global_position.y -= size.y

func show_item(item: Item) -> void:
	alias.text = item.alias
	if item.useable:
		cooldown.text = "Cooldown: " + str(item.use_effect.cooldown_group.cooldown) + " seconds"
		cooldown.visible = true
		use_description.text = "Use: " + item.use_description
		use_description.visible = true
	else:
		cooldown.visible = false
		use_description.visible = false
	if item.limited:
		limit.text = "Limit: " + str(Globals.get_inventory().get_item_amount(item)) + "/" + str(item.limit)
		limit.visible = true
	else:
		limit.visible = false
	if item.description != null and item.description != "":
		description.text = "\"" + item.description + "\""
		description.visible = true
	else:
		description.visible = false
