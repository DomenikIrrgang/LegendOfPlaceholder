class_name Dash
extends Ability

func use(unit: Unit, _target: Unit) -> void:
	super(unit, _target)
	unit.movement_state.transition_to("Dash")
	
func get_dash_resource() -> DashCharge:
	return Globals.get_player().get_resource(ResourceType.Enum.DASH_CHARGE)
	
func get_charges() -> int:
	return get_dash_resource().get_charges()

func get_max_charges() -> int:
	return get_dash_resource().get_maximum_charges()

func update(_delta: float) -> void:
	if not get_dash_resource().resource_value_changed.is_connected(dash_charges_changed):
		get_dash_resource().resource_value_changed.connect(dash_charges_changed)
		
func dash_charges_changed(_resourcce: UnitResource, new_value: int, change: int, _original_change: int) -> void:
	charges_changed.emit(new_value, change)
	
func can_use(unit: Unit) -> bool:
	return super(unit) and unit.movement_state.can_transition_to_state("Dash")
