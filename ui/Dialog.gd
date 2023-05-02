extends CenterContainer

@onready
var textbox = $Background/TextBox

@onready
var keybind = $Background/ConfirmationBox/Keybind

@onready
var icon: TextureRect = $Background/Icon

signal dialog_step_finished(dialog_step: DialogStep)

var dialog_step: DialogStep
var dialog_step_is_finished: bool = false

func _ready() -> void:
	keybind.keybind_pressed.connect(dialog_confirmation_pressed)
	textbox.dialog_text_stream_end.connect(on_dialog_text_stream_end)

func show_dialog_step(_dialog_step: DialogStep) -> void:
	dialog_step = _dialog_step
	dialog_step_is_finished = false
	textbox.show_text(dialog_step)
	icon.texture = dialog_step.author.dialog_texture
	
func on_dialog_text_stream_end(dialog_step: DialogStep) -> void:
	dialog_step_is_finished = true
	
func dialog_confirmation_pressed() -> void:
	if dialog_step_is_finished:
		dialog_step_finished.emit(dialog_step)
