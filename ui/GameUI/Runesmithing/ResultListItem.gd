extends PanelContainer

@onready
var icon: TextureRect = $MarginContainer/HBoxContainer/Icon

@onready
var item_label: Label = $MarginContainer/HBoxContainer/Item

# This is for tooltip
var item_instance: ItemInstance
var ingridient: Ingredient

func _ready() -> void:
	gui_input.connect(on_gui_input)
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and ingridient is DynamicIngridient:
		var selection_list_entries: Array[SelectionListEntryData] = []
		selection_list_entries.append_array(	ingridient.get_possible_ingriedients_from_inventory().map(func(item_instance: ItemInstance):
				return SelectionListEntryData.new(
					item_instance.item.icon,
					item_instance.item.alias,
					item_instance)
		))
		SelectionListManager.selection_made.connect(on_selection_made)
		SelectionListManager.prompt_selection(
			"Choose Ingridient",
			selection_list_entries
		)
		
func on_selection_made(selection: SelectionListEntryData) -> void:
	ingridient.item_instance = selection.data
	set_ingridient(ingridient)
	grab_focus()
	
func set_ingridient(_ingridient: Ingredient) -> void:
	ingridient = _ingridient
	if not (ingridient is DynamicIngridient):
		item_label.text = (str(ingridient.amount) + "x " if ingridient.amount > 1 else "") + ingridient.item.alias
		icon.texture = ingridient.item.icon
		item_instance = Globals.new_item_instance(ingridient.item)
	else:
		if ingridient.item_instance == null:
			item_label.text = "Select Ingridient"
			icon.texture = load("res://Resources/Gear/RunesmithSet/RunesmithsHeadband.tres").icon
		else:
			item_label.text = ingridient.item_instance.item.alias
			icon.texture = ingridient.item_instance.item.icon
		item_instance = ingridient.item_instance
		
func _notification(what):
	if (what == NOTIFICATION_PREDELETE) and ingridient is DynamicIngridient:
		ingridient.item_instance = null
