const Unit = preload("res://src/combat/Unit.gd")
const Ability = preload("res://src/combat/abilities/Ability.gd")

var unit
var target
var ability

func _init(param_unit: Unit, param_target: Unit, param_ability: Ability):
	unit = param_unit
	target = param_target
	ability = param_ability
