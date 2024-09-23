extends Node

signal selection_prompted()
signal selection_made(selection_list_entry_data: SelectionListEntryData)

var focus_cache: Dictionary

func prompt_selection(prompt: String, selection_list_entries: Array[SelectionListEntryData]) -> void:
	var selection_list = Globals.get_tree().get_first_node_in_group("SelectionList")
	focus_cache = UIFocusManager.contain_focus_in_control(selection_list)
	selection_list.visible = true
	selection_list.selection_made.connect(on_selection_made)
	selection_list.prompt_selection(prompt, selection_list_entries)
	selection_prompted.emit()
	
func on_selection_made(selection_list_entry_data: SelectionListEntryData) -> void:
	var selection_list = Globals.get_tree().get_first_node_in_group("SelectionList")
	UIFocusManager.restore_focus_in_ui(focus_cache)
	selection_list.visible = false
	selection_list.selection_made.disconnect(on_selection_made)
	selection_made.emit(selection_list_entry_data)
