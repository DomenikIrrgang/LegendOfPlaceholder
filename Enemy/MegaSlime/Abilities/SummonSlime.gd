extends Ability

func use(source: Unit, target: Unit) -> void:
	super(source, target)
	var slime = preload("res://Enemy/Slime/Slime.tscn").instantiate()
	source.get_parent().add_child(slime)
	var position = source.global_position + target.global_position.direction_to(source.global_position).normalized().rotated(0.5 * PI) * 30
	slime.global_position = Globals.get_first_collision(source.get_world_2d(), source.global_position, position, [source, target])
	source.resource_link.add_unit(slime)
