class_name Equipment
extends Node

enum Enum {
	RUNESMITHS_PANTS,
	RUNESMITHS_HEADBAND,
	RUNESMITHS__SHIRT,
}

const data = {
	Equipment.Enum.RUNESMITHS_PANTS: "res://Resources/Gear/RunesmithSet/RunesmithsPants.tres",
	Equipment.Enum.RUNESMITHS_HEADBAND: "res://Resources/Gear/RunesmithSet/RunesmithsHeadband.tres",
	Equipment.Enum.RUNESMITHS__SHIRT: "res://Resources/Gear/RunesmithSet/RunesmithsShirt.tres",
}

static func get_gear_data(gear: Equipment.Enum) -> Gear:
	return load(Equipment.data[gear])
