extends Ability

func use(source: Unit, target: Unit) -> void:
	var heal_slime = preload("res://Enemy/HealSlime/HealSlime.tscn").instantiate()
	heal_slime.set_heal_target(source)
	source.get_parent().add_child(heal_slime)
	heal_slime.global_position = source.global_position + target.global_position.direction_to(source.global_position).normalized() * 30
