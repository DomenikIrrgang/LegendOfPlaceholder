extends PanelContainer

@onready
var prompt: Label = $CenterContainer/Content/Prompt

@onready
var list: VBoxContainer = $CenterContainer/Content/ScrollContainer/MarginContainer/List

@onready
var item_tooltip: ItemTooltip = $MarginContainer/CenterContainer/ItemTooltip

var SelectionListEntry = preload("res://ui/GameUI/SelectionList/SelectionListEntry.tscn")

signal selection_made(selection_list_entry_data: SelectionListEntryData)

func _ready() -> void:
	item_tooltip.position_with_container()
	item_tooltip.visible = false

func prompt_selection(_prompt: String, selection_list: Array[SelectionListEntryData]) -> void:
	Globals.free_children(list)
	if selection_list.size() > 1:
		prompt.text = _prompt
		var first_entry = null
		for list_entry in selection_list:
			var selection_list_entry = SelectionListEntry.instantiate()
			if first_entry == null:
				first_entry = selection_list_entry
			list.add_child(selection_list_entry)
			selection_list_entry.initialize(list_entry)
			selection_list_entry.focus_entered.connect(func():
				if list_entry.data is ItemInstance:
					item_tooltip.visible = true
					item_tooltip.show_item(list_entry.data)
				else:
					item_tooltip.visible = false
			)
			selection_list_entry.entry_selected.connect(selection_list_entry_selected)
		first_entry.grab_focus()
		
func selection_list_entry_selected(selection_list_entry_data: SelectionListEntryData) -> void:
	item_tooltip.visible = false
	selection_made.emit(selection_list_entry_data)
