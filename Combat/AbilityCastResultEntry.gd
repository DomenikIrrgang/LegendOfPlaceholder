var hit_type
var ability_value = 0
var value = 0
var source
var target
var original_target
var resist_amount = 0

func _init(param_source, param_target):
	source = param_source
	target = param_target
	original_target = target

func is_reflected():
	return target != original_target
