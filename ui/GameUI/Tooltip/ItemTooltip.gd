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

@onready
var use_conditions = $MarginContainer/VBoxContainer/UseConditions

@onready
var runes = $MarginContainer/VBoxContainer/Runes

var ActiveSetPieceName = preload("res://ui/GameUI/Tooltip/SetPieceActive.tscn")
var InactiveSetPieceName = preload("res://ui/GameUI/Tooltip/SetPieceInactive.tscn")

var ActiveBonus = preload("res://ui/GameUI/Tooltip/BonusActive.tscn")
var InactiveBonus = preload("res://ui/GameUI/Tooltip/BonusInactive.tscn")

var RuneSlotTooltip = preload("res://ui/GameUI/Tooltip/RuneSlot.tscn")

enum PositionMode {
	CURSOR,
	NODE,
	FIXED,
	CONTAINER
}

var position_mode: PositionMode = PositionMode.CURSOR
var attached_node: Node = null
var fixed_position: Vector2 = Vector2(0, 0)

var should_be_visible: bool = false

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	update_position()
		
func update_position() -> void:
	visible = should_be_visible
	if position_mode == PositionMode.CURSOR:
		global_position = get_viewport().get_mouse_position()
		if global_position.x >= get_viewport().get_visible_rect().size.x / 2:
			global_position.x -= size.x
		if global_position.y >= get_viewport().get_visible_rect().size.y / 2:
			global_position.y -= size.y
	if position_mode == PositionMode.NODE:
		if attached_node.global_position.y >= get_viewport().get_visible_rect().size.y / 2:
			global_position.y = attached_node.global_position.y - size.y
		else:
			global_position.y = attached_node.global_position.y + attached_node.size.y
		if attached_node.global_position.x >= get_viewport().get_visible_rect().size.x / 2:
			global_position.x = attached_node.global_position.x - size.x + attached_node.size.x
		else:
			global_position.x = attached_node.global_position.x
	if position_mode == PositionMode.FIXED:
		global_position = fixed_position
func set_fixed_position(_fixed_position: Vector2) -> void:
	position_mode = PositionMode.FIXED
	fixed_position = _fixed_position
	
func attach_to_node(node: Node) -> void:
	position_mode = PositionMode.NODE
	attached_node = node
	
func position_with_container() -> void:
	position_mode = PositionMode.CONTAINER

func show_item(item_instance: ItemInstance) -> void:
	alias.text = item_instance.item.alias
	if item_instance.item.useable:
		cooldown.text = "Cooldown: " + str(item_instance.item.use_effect.cooldown_group.cooldown) + " seconds"
		cooldown.visible = false
		if item_instance.item.use_effect.conditions.size() > 0:
			Globals.free_children(use_conditions)
			use_conditions.visible = true
			for condition in item_instance.item.use_effect.conditions:
				var label = Label.new()
				label.text = condition.get_string()
				if condition.is_fulfilled():
					label.self_modulate = Color.GREEN
				else:
					label.self_modulate = Color.RED
				use_conditions.add_child(label)
		use_description.text = "Use: " + item_instance.item.use_description + " (" + str(item_instance.item.use_effect.cooldown_group.cooldown) + " seconds cooldown)"
		use_description.visible = true
	else:
		cooldown.visible = false
		use_conditions.visible = false
		use_description.visible = false
	if item_instance.item.limited:
		limit.text = "Limit: " + str(Globals.get_inventory().get_item_amount(item_instance.item)) + "/" + str(item_instance.item.limit)
		limit.visible = true
	else:
		limit.visible = false
	if item_instance.item.description != null and item_instance.item.description != "":
		description.text = "\"" + item_instance.item.description + "\""
		description.visible = true
	else:
		description.visible = false
	if item_instance is GearInstance:
		slot.text = Gear.Slot.keys()[item_instance.item.slot].capitalize()
		slot.visible = true
		stats.text = ""
		equip_description.text = ""
		equip_description.visible = false
		stats.visible = false
		if item_instance.item.rune_slots.size() > 0:
			runes.visible = true
			Globals.free_children(runes)
			for i in item_instance.item.rune_slots.size():
				var tooltip = RuneSlotTooltip.instantiate()
				var rune = item_instance.runes[i] if item_instance.runes[i] != null else null
				var rune_slot = RuneSlot.new()
				rune_slot.rune = rune
				rune_slot.spell_school = item_instance.item.rune_slots[i].spell_school
				runes.add_child(tooltip)
				tooltip.set_rune_slot(rune_slot)
		if item_instance.item.gear_set != null:
			set_container.visible = true
			set_name.text = item_instance.item.gear_set.alias
			for set_piece_name in set_piece_names.get_children():
				set_piece_name.queue_free()
			for set_piece in item_instance.item.gear_set.set_pieces:
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
			for bonus in item_instance.item.gear_set.get_ordered_bonuses():
				var label
				if item_instance.item.gear_set.is_bonus_completed(bonus):
					label = ActiveBonus.instantiate()
				else:
					label = InactiveBonus.instantiate()
				label.text = "Set (" + str(bonus.required_pieces) + ") " + bonus.description
				bonuses.add_child(label)
		else:
			set_container.visible = false
		item_instance.item.gear_effects.sort_custom(func(a, b): return a is StatGearEffect)
		for gear_effect in item_instance.item.gear_effects:
			if gear_effect is StatGearEffect:
				stats.text = gear_effect.get_description()
				stats.visible = true
			if gear_effect is OnEquipEffect:
				equip_description.text = equip_description.text + "On Equip: " + gear_effect.description + "\n"
				equip_description.visible = true
	else:
		slot.visible = false
		stats.visible = false
		equip_description.visible = false
		set_container.visible = false
		runes.visible = false
		Globals.free_children(runes)
