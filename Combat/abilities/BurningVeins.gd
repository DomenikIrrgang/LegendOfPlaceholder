extends Ability

var BurningVeins = load("res://Resources/StatusEffects/BurningVeins.tres")

func use(_source: Unit, target: Unit) -> void:
	super(_source, target)
	target.apply_status_effect(BurningVeins, target, 5)
