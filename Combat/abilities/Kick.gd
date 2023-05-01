extends Ability

@export
var radius: float = 20.0

func use(source: Unit, _target: Unit) -> void:
	super(source, _target)
	var targets = Globals.get_units_around_unit(source, radius)
	for target in targets:
		if target.is_casting():
			target.interupt_casting()

