class_name AbilityCastResultEntry

var hit_type: int
var ability_value: int = 0
var value: int = 0
var source: Unit
var target: Unit
var original_target: Unit
var resist_amount: int = 0

func _init(_source: Unit, _target: Unit):
	source = _source
	target = _target
	original_target = target

func is_reflected():
	return target != original_target
