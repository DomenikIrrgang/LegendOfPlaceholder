extends Ability

func use(source: Unit, target: Unit) -> void:
	super(source, target)
	var egg = preload("res://Enemy/Egg/Egg.tscn").instantiate()
	source.get_parent().add_child(egg)
	var position = source.global_position + target.global_position.direction_to(source.global_position).normalized().rotated(0.5 * PI) * 30
	egg.global_position = Globals.get_first_collision(source.get_world_2d(), source.global_position, position, [source, target])
