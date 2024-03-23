extends VBoxContainer

@onready
var unit_name_label: Label = $VBoxContainer/HBoxContainer/Portrait/UnitName

@onready
var unit_icon: TextureRect = $VBoxContainer/HBoxContainer/Portrait/PanelContainer/MarginContainer/Icon

@onready
var interaction_menu: Container = $VBoxContainer/HBoxContainer/InteractionMenue

var InteractionOptionComponent = preload("res://ui/GameUI/InteractionMenu/InteractionOption.tscn")

var selected_option: int = 0
var interactions: Array[Interaction]

func _ready():
	InteractionManager.interaction_prompt_requested.connect(on_interaction_prompt_requested)
	InteractionManager.interaction_prompt_stopped.connect(on_interaction_prompt_stopped)
	visible = false
	
func on_interaction_prompt_requested(unit_data: UnitData, _interactions: Array[Interaction]) -> void:
	InputControlls.input_event.connect(on_input)
	interactions = _interactions
	selected_option = 0
	unit_name_label.text = unit_data.alias
	unit_icon.texture = unit_data.interaction_texture
	for interaction in interactions:
		var interaction_option: InteractionOption = InteractionOptionComponent.instantiate()
		interaction_menu.add_child(interaction_option)
		interaction_option.init(interaction)
		interaction_option.gui_input.connect(func(event: InputEvent):
			if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
				select_option(interactions.find(interaction))
				do_selected_interaction()
		)
	select_option(interaction_menu.get_child_count() - 1)
	visible = true
	
func on_input(state: InputState) -> void:
	if state.action_map.has("ui_accept") and state.action_map["ui_accept"] == true:
		do_selected_interaction()
	if state.action_map.has("up") and state.action_map["up"] == true:
		select_option(selected_option - 1 if selected_option > 0 else interaction_menu.get_child_count() - 1)
	if state.action_map.has("down") and state.action_map["down"] == true:
		select_option(selected_option + 1 if selected_option < interaction_menu.get_child_count() - 1 else 0)
		
func do_selected_interaction() -> void:
	InteractionManager.select_interaction(interactions[selected_option])
		
func select_option(index: int) -> void:
	interaction_menu.get_child(selected_option).unselect()
	selected_option = index
	interaction_menu.get_child(index).select()
	
func on_interaction_prompt_stopped() -> void:
	visible = false
	for interaction_option in interaction_menu.get_children():
		interaction_option.queue_free()
	InputControlls.input_event.disconnect(on_input)
