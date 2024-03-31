class_name Units
extends Node

enum Enum {
	PLAYER,
	ALFOND,
	MEGA_SLIME,
	ELEMENTAL_SLIME,
	VISJALA,
	SAVE_CRYSTAL,
	BACKPACK,
}

const data = {
	Units.Enum.PLAYER: preload("res://Resources/Player/PlayerData.tres"),
	Units.Enum.ALFOND: preload("res://Resources/Npcs/Alfond.tres"),
	Units.Enum.MEGA_SLIME: preload("res://Resources/Enemies/MegaSlime.tres"),
	Units.Enum.ELEMENTAL_SLIME: preload("res://Resources/Enemies/ElementalSlime.tres"),
	Units.Enum.VISJALA: preload("res://Resources/Enemies/Visjala.tres"),
	Units.Enum.SAVE_CRYSTAL: preload("res://Resources/Npcs/SaveCrystal.tres"),
	Units.Enum.BACKPACK: preload("res://Resources/Npcs/Backpack.tres"),
}

static func get_unit_data(unit: Units.Enum) -> UnitData:
	return Units.data[unit]
