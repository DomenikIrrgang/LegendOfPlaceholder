class_name Energy
extends UnitResource

var energy_fragment: float = 0.0
var energy_rate: float = 1.0

func _init(_unit: Unit) -> void:
	super(_unit)
	type = ResourceType.Enum.ENERGY
	set_maximum_value(20)
	set_value(0)
	energy_rate = 1.0 + stat_calculator.get_haste()

func get_maximum_value() -> int:
	return super.get_maximum_value() + stat_calculator.get_energy()

func update(delta):
	if energy_fragment >= 1.0:
		increase_value(1)
		energy_fragment = 0.0
	else:
		energy_fragment += delta * energy_rate

func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.ENERGY:
		resource_maximum_value_changed.emit(self, get_maximum_value(), get_maximum_value())
	energy_rate = 1.0 + stat_calculator.get_haste()
