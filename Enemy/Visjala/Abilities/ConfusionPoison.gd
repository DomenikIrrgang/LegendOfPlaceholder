extends Ability

var ConfusionPoisonStatusEffect = load("res://Resources/StatusEffects/ConfusionPoison.tres")

func use(source: Unit, target: Unit) -> void:
	target.apply_status_effect(ConfusionPoisonStatusEffect, source)
