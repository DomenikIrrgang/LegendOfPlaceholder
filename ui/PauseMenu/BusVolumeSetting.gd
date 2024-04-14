extends HSlider

@export
var bus_name: String

var bus_index: int

func _ready() -> void:
	step = 0.01
	min_value = 0.0
	max_value = 1.0
	bus_index = AudioServer.get_bus_index(bus_name)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	value_changed.connect(on_value_changed)
	
func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
