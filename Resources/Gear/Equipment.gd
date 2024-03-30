class_name Equipment
extends Node

enum Enum {
	RUNESMITHS_PANTS,
	RUNESMITHS_HEADBAND,
	RUNESMITHS__SHIRT,
}

const data = {
	Equipment.Enum.RUNESMITHS_PANTS: preload("res://Resources/Gear/RunesmithSet/RunesmithsPants.tres"),
	Equipment.Enum.RUNESMITHS_HEADBAND: preload("res://Resources/Gear/RunesmithSet/RunesmithsHeadband.tres"),
	Equipment.Enum.RUNESMITHS__SHIRT: preload("res://Resources/Gear/RunesmithSet/RunesmithsShirt.tres"),
}

static func get_gear_data(gear: Equipment.Enum) -> Gear:
	return Equipment.data[gear]
