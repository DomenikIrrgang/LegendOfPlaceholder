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

@onready
var slot: Label = $MarginContainer/VBoxContainer/Slot

@onready
var equip_description: Label = $MarginContainer/VBoxContainer/EquipDescription

@onready
var stats: Label = $MarginContainer/VBoxContainer/Stats

@onready
var set_container: Container = $MarginContainer/VBoxContainer/Set

@onready
var set_name: Label = $MarginContainer/VBoxContainer/Set/VBoxContainer/SetName

@onready
var set_piece_names: Container = $MarginContainer/VBoxContainer/Set/VBoxContainer/Pieces/VBoxContainer

@onready
var bonuses: Container = $MarginContainer/VBoxContainer/Set/VBoxContainer/Bonuses

var ActiveSetPieceName = preload("res://ui/GameUI/Tooltip/SetPieceActive.tscn")
var InactiveSetPieceName = preload("res://ui/GameUI/Tooltip/SetPieceInactive.tscn")

var ActiveBonus = preload("res://ui/GameUI/Tooltip/BonusActive.tscn")
var InactiveBonus = preload("res://ui/GameUI/Tooltip/BonusInactive.tscn")

func _process(_delta: float) -> void:
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
		cooldown.visible = false
		use_description.text = "Use: " + item.use_description + " (" + str(item.use_effect.cooldown_group.cooldown) + " seconds cooldown)"
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
	if item is Gear:
		slot.text = Gear.Slot.keys()[item.slot].capitalize()
		slot.visible = true
		stats.text = ""
		equip_description.text = ""
		equip_description.visible = false
		stats.visible = false
		if item.gear_set != null:
			set_container.visible = true
			set_name.text = item.gear_set.alias
			for set_piece_name in set_piece_names.get_children():
				set_piece_name.queue_free()
			for set_piece in item.gear_set.set_pieces:
				var gear = Equipment.get_gear_data(set_piece)
				var label
				if Globals.get_player().has_gear_equipped(gear):
					label = ActiveSetPieceName.instantiate()
				else:
					label = InactiveSetPieceName.instantiate()
				label.text = gear.alias
				set_piece_names.add_child(label)
			for bonus in bonuses.get_children():
				bonus.queue_free()
			for bonus in item.gear_set.get_ordered_bonuses():
				var label
				if item.gear_set.is_bonus_completed(bonus):
					label = ActiveBonus.instantiate()
				else:
					label = InactiveBonus.instantiate()
				label.text = "Set (" + str(bonus.required_pieces) + ") " + bonus.description
				bonuses.add_child(label)
		else:
			set_container.visible = false
		for gear_effect in item.gear_effects:
			if gear_effect is StatGearEffect:
				for stat_assignment in gear_effect.stats:
					stats.text = stats.text + "+ " + str(stat_assignment.value) + " " + Stat.Enum.keys()[stat_assignment.stat].capitalize() + "\n"
				stats.visible = true
			if gear_effect is OnEquipEffect:
				equip_description.text = equip_description.text + "On Equip: " + gear_effect.tooltip + "\n"
				equip_description.visible = true
	else:
		slot.visible = false
		stats.visible = false
		equip_description.visible = false
		set_container.visible = false
