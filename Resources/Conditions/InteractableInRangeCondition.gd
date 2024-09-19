class_name InteractableInRangeCondition
extends Condition

@export
var interactable_unit_name: String

func is_fulfilled() -> bool:
	for interactable in Globals.get_player().interaction.interactables_in_range:
		var unit = interactable.owner
		if interactable.owner.unit_data.alias == interactable_unit_name:
			return true
	return false
	
func get_string() -> String:
	return "Needs to be close to " + interactable_unit_name
