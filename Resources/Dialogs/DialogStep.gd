@tool
class_name DialogStep
extends Resource

@export
var type: DialogType.Enum

@export
var author: UnitData

@export_multiline
var text: String

@export
var choices: Array[DialogChoice]

#func set_type(_type: DialogType.Enum) -> void:
#	type = _type
#	notify_property_list_changed()

#func _get_property_list() -> Array:
#	var list = []
#	if type == DialogType.Enum.CHOICE:
#		list.push_back(
#			{ name = "choices", type = TYPE_ARRAY },
#		)
#	return list
