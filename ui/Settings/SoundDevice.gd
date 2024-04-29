extends OptionButton

func _ready():
	item_selected.connect(on_device_selected)
	for device in AudioServer.get_output_device_list():
		add_item(device)
		if device == AudioServer.output_device:
			select(AudioServer.get_output_device_list().find(device))
		
func on_device_selected(index: int) -> void:
	AudioServer.output_device = AudioServer.get_output_device_list()[index]
