extends TextureRect

@export
var all: bool = false

@export
var spell_school: SpellSchool.Enum

@export
var selected: bool = false

var spell_school_icon_map = {
	SpellSchool.Enum.PHYSICAL: load("res://assets/ui/items/physical_spelltome.png"),
	SpellSchool.Enum.FIRE: load("res://assets/ui/items/fire_spelltome.png"),
	SpellSchool.Enum.FROST: load("res://assets/ui/items/frost_spelltome.png"),
	SpellSchool.Enum.WIND: load("res://assets/ui/items/wind_spelltome.png"),
	SpellSchool.Enum.EARTH: load("res://assets/ui/items/earth_spelltome.png"),
	SpellSchool.Enum.LIGHT: load("res://assets/ui/items/light_spelltome.png"),
	SpellSchool.Enum.SHADOW: load("res://assets/ui/items/shadow_spelltome.png"),
	SpellSchool.Enum.NATURE: load("res://assets/ui/items/nature_spelltome.png"),
	SpellSchool.Enum.WATER: load("res://assets/ui/items/water_spelltome.png"),
	SpellSchool.Enum.THUNDER: load("res://assets/ui/items/thunder_spelltome.png"),
	SpellSchool.Enum.GRAVITY: load("res://assets/ui/items/gravity_spelltome.png")
		
}

@onready
var icon: TextureRect = $Icon

@onready
var border: TextureRect = $Border

var text: String = ""

signal spell_school_selected(spell_school: SpellSchool.Enum)

func _ready() -> void:
	if all:
		spell_school = -1
	icon.texture = spell_school_icon_map[spell_school] if spell_school_icon_map.has(spell_school) else load("res://assets/ui/items/all_elements.png")
	if spell_school != -1:
		text = SpellSchool.Enum.keys()[spell_school].capitalize()
	else:
		text = "All"
	set_selected(selected)
		
func set_selected(_selected: bool) -> void:
	selected = _selected
	border.visible = selected

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		spell_school_selected.emit(spell_school)
