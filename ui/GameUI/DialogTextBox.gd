extends VBoxContainer

@onready
var author_label: Label = $Author

@onready
var text_label: Label = $Text

@onready
var confirmation_box = get_node("../ConfirmationBox")

var text_speed: float = 60.0
var streaming_text: bool = true

var dialog_step: DialogStep

var timer: Timer

enum DialogToken {
	SPEED,
	BOLD,
	PAUSE,
	KEYBIND,
	TEXTURE
}

signal dialog_text_stream_update(dialog_step: DialogStep)
signal dialog_text_stream_end(dialog_step: DialogStep)

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(on_write_timer)
	add_child(timer)
	dialog_text_stream_end.connect(on_dialog_text_stream_end)

func show_text(_dialog_step: DialogStep) -> void:
	dialog_step = _dialog_step
	author_label.text = Units.get_unit_data(dialog_step.author).alias
	if not streaming_text:
		text_label.text = dialog_step.text
		dialog_text_stream_end.emit(dialog_step)
	else:
		text_label.text = ""
		timer.start(1.0 / text_speed)
	confirmation_box.visible = false
	
		
func on_write_timer() -> void:
	text_label.text = dialog_step.text.substr(0, text_label.text.length() + 1)
	if text_label.text == dialog_step.text:
		timer.stop()
		dialog_text_stream_end.emit(dialog_step)
	else:
		dialog_text_stream_update.emit(dialog_step, text_label.text)
		
func on_dialog_text_stream_end(_dialog_step: DialogStep) -> void:
	confirmation_box.visible = true
