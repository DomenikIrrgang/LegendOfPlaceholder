extends HSlider

@export
var channel: SoundManager.Channel

func _ready():
	min_value = SoundManager.MIN_VOLUME
	max_value = SoundManager.MAX_VOLUME
	value = SoundManager.get_volume(channel)
	value_changed.connect(on_value_changed)
	
func on_value_changed(value: float) -> void:
	SoundManager.set_volume(channel, value)
	print(value)
