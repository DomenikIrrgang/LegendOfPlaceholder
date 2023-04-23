const Ability = preload("res://src/combat/abilities/Ability.gd")

var ability: Ability
var results: Array

func _init(param_ability, param_results):
	ability = param_ability
	results = param_results
