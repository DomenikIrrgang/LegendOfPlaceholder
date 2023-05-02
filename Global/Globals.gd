extends Node

func get_player() -> Player:
	return get_scene_tree().get_first_node_in_group("player")
	
func get_user_interface() -> CanvasLayer:
	return get_scene_tree().get_first_node_in_group("UserInterfaceCanvas")

func get_scene_tree() -> SceneTree:
	return get_tree()

func random_chance(chance: float) -> bool:
	return (randf() * 100.0) <= chance
	
func start_enemies() -> void:
	var enemies = get_scene_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.start()
		
func pause_enemies() -> void:
	var enemies = get_scene_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.pause()

# min and max have to be between 0.0 and 1.0	
func random_value(minimum: float, maximum: float) -> float:
	return randf() * (maximum - minimum) + minimum
	
func get_first_collision(world: World2D, source: Vector2, target: Vector2, exclude: Array) -> Vector2:
	var space_state = world.direct_space_state
	var query = PhysicsRayQueryParameters2D.create(source, target)
	query.exclude = exclude
	var result = space_state.intersect_ray(query)
	if result:
		return result.position - (target - source).normalized() * 3
	return target
	
func get_units_around_unit(source: Unit, radius: float, execlude: Array[Unit] = []) -> Array[Unit]:
	var result: Array[Unit] = []
	for target in get_scene_tree().get_nodes_in_group("unit"):
		var distance = (source.global_position - target.global_position).length()
		if distance <= radius and target != source and not execlude.has(target):
			result.append(target)
	return result
