extends HSlider

@export
var channel: SoundManager.Channel

func _ready() -> void:
	step = 0.01
	min_value = 0.0
	max_value = 1.0
	value = SoundManager.get_channel_volume(channel)
	value_changed.connect(on_value_changed)
	SoundManager.channel_volume_changed.connect(on_channel_volume_changed)
	
func on_channel_volume_changed(_channel: SoundManager.Channel, volume: float) -> void:
	if channel == _channel:
		value = volume
	
func on_value_changed(volume: float) -> void:
	SoundManager.set_channel_volume(channel, volume)
