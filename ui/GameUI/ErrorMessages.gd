extends Control

var ErrorMessageLabel = preload("res://Ui/GameUI/ErrorMessage.tscn")

@onready
var container: Container = $CenterContainer/Container

func _ready() -> void:
	Error.receive.connect(on_error)
	
func on_error(message: String) -> void:
	var error_message: ErrorMessage = has_error_message(message)
	if error_message == null:
		error_message = ErrorMessageLabel.instantiate()
		container.add_child(error_message)
		error_message.show_message(message)
	else:
		error_message.reset()
	
func has_error_message(message: String) -> ErrorMessage:
	for child in container.get_children():
		if child.text == message:
			return child
	return null
