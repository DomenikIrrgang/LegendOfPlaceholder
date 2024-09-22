class_name GearInstance
extends ItemInstance

var runes: Array[Rune] = []

func get_gear_effects() -> Array[GearEffect]:
	var result: Array[GearEffect] = []
	result.append_array(item.gear_effects)
	result.append_array(runes.map(func(rune: Rune):
		if rune != null:
			return rune.effect
		return null
	).filter(func(gear_effect: GearEffect):
		return gear_effect != null
	))
	return result

func get_save_data() -> Dictionary:
	return {
		"runes": runes.map(func(rune: Rune): 
			if rune != null:
				return SaveFileManager.get_resource_uid(rune)
			return null
			)
	}

func load_save_data(save_data: Dictionary) -> void:
	if save_data.has("runes"):
		var loaded_runes = save_data.runes.map(func(uid: String):
			return SaveFileManager.get_resource_from_uid(uid)
		)
		for i in loaded_runes.size():
			runes[i] = loaded_runes[i]

func set_item(_item: Item) -> void:
	super(_item)
	runes.resize(item.rune_slots.size())
	runes.fill(null)
	
