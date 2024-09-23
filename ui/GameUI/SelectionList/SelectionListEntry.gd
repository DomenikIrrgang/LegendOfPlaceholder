extends PanelContainer

@onready
var label: Label = $MarginContainer/Content/Label

@onready
var icon: TextureRect = $MarginContainer/Content/Icon

signal entry_selected(selection_list_entry_data: SelectionListEntryData)

var data: SelectionListEntryData

func _ready() -> void:
	gui_input.connect(on_gui_input)

func initialize(entry_data: SelectionListEntryData) -> void:
	data = entry_data
	icon.texture = entry_data.icon
	label.text = entry_data.text
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		entry_selected.emit(data)
