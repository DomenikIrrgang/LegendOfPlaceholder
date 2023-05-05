extends Ability

func use(source: Unit, target: Unit) -> void:
	var heal_slime = preload("res://Enemy/HealSlime/HealSlime.tscn").instantiate()
	heal_slime.set_heal_target(source)
	source.get_parent().add_child(heal_slime)
	#var position = source.global_position + target.global_position.direction_to(source.global_position).normalized() * 30
	var random_x = randi_range(-17, 17)
	var random_y = randi_range(-17, 17)
	var position = target.global_position
	if random_x == 0:
		random_x = 1
	if random_y == 0:
		random_y = 1
	position.x += ((abs(random_x) / random_x) * 8) + random_x
	position.y += ((abs(random_y) / random_y) * 8) + random_y
	heal_slime.global_position = Globals.get_first_collision(source.get_world_2d(), target.global_position, position, [source, target])
