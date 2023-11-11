extends CenterContainer

@onready
var textbox = $Background/TextBox

@onready
var keybind = $Background/Keybind

@onready
var icon: TextureRect = $Background/Icon

@onready
var choices_container = $Background/TextBox/MarginContainer/Choices

signal dialog_step_finished(dialog_step: DialogStep, dialog_chpice: DialogChoice)

var dialog_step: DialogStep
var dialog_step_is_finished: bool = false

var selected_choice: SelectableLabel

func _ready() -> void:
	keybind.keybind_pressed.connect(dialog_confirmation_pressed)
	textbox.dialog_text_stream_end.connect(on_dialog_text_stream_end)
	get_viewport().gui_focus_changed.connect(on_focus_changed)

func show_dialog_step(_dialog_step: DialogStep) -> void:
	dialog_step = _dialog_step
	dialog_step_is_finished = false
	textbox.show_text(dialog_step)
	icon.texture = dialog_step.author.dialog_texture
	choices_container.get_children().filter(func(child): child.queue_free())
	choices_container.visible = false
	
func on_dialog_text_stream_end(_dialog_step: DialogStep) -> void:
	dialog_step_is_finished = true
	if _dialog_step.type == DialogType.Enum.CHOICE:
		choices_container.visible = true
		for choice in _dialog_step.choices:
			add_choice(choice.text)
		choices_container.get_child(0).grab_focus()
	
func dialog_confirmation_pressed() -> void:
	if dialog_step_is_finished:
		if selected_choice != null:
			dialog_step.choose(get_dialog_choice(selected_choice.label.text))
			dialog_step.approve()
			selected_choice = null
		else:
			dialog_step.approve()		
		
func add_choice(choice: String) -> void:
	var choice_label = load("res://ui/SelectableLabel.tscn").instantiate()
	choices_container.add_child(choice_label)
	choice_label.label.text = choice

func on_focus_changed(control: Control) -> void:
	if control is SelectableLabel:
		selected_choice = control

func get_dialog_choice(text: String) -> DialogChoice:
	for choice in dialog_step.choices:
		if choice.text == text:
			return choice
	return null
