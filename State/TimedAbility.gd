class_name TimedAbility
extends Node

var ability: Ability
var target
var cooldown_min: float
var cooldown_max: float
var activation_chance: float
var executed: bool = false
	
func _init(_ability: Ability, _target, _cooldown_min: float, _cooldown_max: float, _activation_chance: float = 100.0):
	ability = _ability
	target = _target
	cooldown_min = _cooldown_min
	cooldown_max = _cooldown_max
	activation_chance = _activation_chance
