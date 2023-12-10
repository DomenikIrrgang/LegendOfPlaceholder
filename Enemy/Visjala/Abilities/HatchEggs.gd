extends Ability


func use(source: Unit, _target: Unit) -> void:
	for node in Globals.get_loaded_scene_node().get_children():
		if node is Egg:
			var snake = Globals.spawn_unit(
				load("res://Enemy/SmallSnake/SmallSnake.tscn").instantiate(),
				node.global_position
			)
			node.queue_free()
