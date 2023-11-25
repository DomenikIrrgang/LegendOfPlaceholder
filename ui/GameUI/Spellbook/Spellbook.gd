extends HBoxContainer

@onready
var first_column: Array[Node] = $Window/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Content/FirstColumn.get_children()

@onready
var second_column: Array[Node] = $Window/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/Content/SecondColumn.get_children()

@onready
var spell_school_selectors: Array[Node] = $MarginContainer/SpellSchoolSelectors.get_children()

@onready
var page_indicator = $Window/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/CenterContainer/PageIndicator

var spell_school: SpellSchool.Enum = -1
var current_page: int = 0

func _ready():
	Spellbook.new_ability_learned.connect(on_new_ability_learned)
	for selector in spell_school_selectors:
		selector.spell_school_selected.connect(on_spell_school_selected)
	page_indicator.page_changed.connect(on_page_changed)
	page_indicator.set_page_number(current_page, get_maximum_page())
	
func on_page_changed(page: int) -> void:
	update_abilities(page, spell_school)
	
func toggle() -> void:
	if visible:
		close()
	else:
		open()
		
func close() -> void:
	if Globals.get_drag_and_drop().is_dragging() and Globals.get_drag_and_drop().data.has("ability"):
		Globals.get_drag_and_drop().stop_dragging()
	visible = false
	
func open() -> void:
	visible = true
	update_abilities(current_page, spell_school)
		
func on_spell_school_selected(spell_school: SpellSchool.Enum) -> void:
	update_abilities(0, spell_school)
	page_indicator.set_page_number(0, get_maximum_page())
	for selector in spell_school_selectors:
		if selector.spell_school == spell_school:
			selector.set_selected(true)
		else:
			selector.set_selected(false)
			
func get_maximum_page() -> int:
	if spell_school == -1:
		return ceil(float(Spellbook.get_all_abilities().size()) / float((first_column.size() + second_column.size())))
	else:
		return ceil(float(Spellbook.get_abilities_by_spell_school(spell_school).size()) / float((first_column.size() + second_column.size())))
	
func on_new_ability_learned(_ability: Ability) -> void:
	update_abilities(current_page, spell_school)
	page_indicator.set_page_number(current_page, get_maximum_page())
	
func update_abilities(page: int, _spell_schhool: SpellSchool.Enum) -> void:
	current_page = page
	spell_school = _spell_schhool
	var abilities: Array[Ability]
	if spell_school == -1:
		abilities = Spellbook.get_all_abilities()
	else:
		abilities = Spellbook.get_abilities_by_spell_school(spell_school)
	for display in first_column.size():
		var index = (current_page * (first_column.size() + second_column.size())) + display
		if index < abilities.size():
			first_column[display].set_ability(abilities[index])
			first_column[display].visible = true
		else:
			first_column[display].visible = false
	for display in second_column.size():
		var index = (current_page * (first_column.size() + second_column.size())) + first_column.size() + display
		if index < abilities.size():
			second_column[display].set_ability(abilities[index])
			second_column[display].visible = true
		else:
			second_column[display].visible = false
