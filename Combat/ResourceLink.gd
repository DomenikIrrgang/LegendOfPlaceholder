class_name ResourceLink

var units: Array[Unit] = []
var resource_type: ResourceType.Enum

func _init(_resource_type: ResourceType.Enum, _units: Array[Unit]):
	resource_type = _resource_type
	for unit in _units:
		if unit.has_resource(resource_type):
			add_unit(unit)

func on_resource_changed(resource: UnitResource, _new_value: int, change: int, original_change: int) -> void:
	if (units.size() > 1):
		var divided: float = float(original_change) / float(units.size())
		var split = floor(divided)
		var restore = -ceil(divided * (units.size() - 1))
		if (original_change < change):
			restore = abs(change) + split
		var i = 0
		while i < units.size():
			var unit = units[i]
			var unit_resource: UnitResource = unit.get_resource(resource.type)
			if (unit == resource.stat_calculator.get_unit()):
				unit_resource.resource_value_changed.disconnect(on_resource_changed)
				unit.increase_resource_value(resource.type, restore)
				if (not unit.is_dead()):
					unit_resource.resource_value_changed.connect(on_resource_changed)
			else:
				unit_resource.resource_value_changed.disconnect(on_resource_changed)
				unit.increase_resource_value(resource.type, split)
				if (not unit.is_dead()):
					unit_resource.resource_value_changed.connect(on_resource_changed)
			if not unit.is_dead():
				i += 1
				
func add_unit(unit: Unit) -> void:
	units.append(unit)
	unit.died.connect(remove_unit)
	var resource = unit.get_resource(resource_type)
	resource.resource_value_changed.connect(on_resource_changed)
	
func remove_unit(unit: Unit) -> void:
	units.erase(unit)
