class_name Rune
extends Resource

@export
var name: String

@export
var type: SpellSchool.Enum

@export
var effect: GearEffect

var description: String : get = get_description

func get_description() -> String:
	return effect.get_description()
