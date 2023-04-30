extends Ability

func use(source: Unit, target: Unit) -> void:
	super(source, target)
	var slime = preload("res://Enemy/Slime/Slime.tscn").instantiate()
	source.get_parent().add_child(slime)
	slime.global_position = source.global_position + target.global_position.direction_to(source.global_position).normalized().rotated(0.5 * PI) * 30
	source.resource_link.add_unit(slime)
