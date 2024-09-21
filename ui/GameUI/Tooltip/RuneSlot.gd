extends HBoxContainer

@onready
var icon: Label = $Icon

@onready
var description: Label = $Description

func set_rune_slot(rune_slot: RuneSlot) -> void:
	if rune_slot.rune != null:
		icon.text = "⬤"
	else:
		icon.text = "◯"
	if rune_slot.rune != null:
		description.text = rune_slot.rune.description
	else:
		description.text = SpellSchool.Enum.keys()[rune_slot.spell_school].capitalize() + " Rune Slot"
