extends Node

func _process(delta: float) -> void:
	var units: Array[Node] = get_tree().get_nodes_in_group("enemy")
	for unit in units:
		for ability in unit.get_abilities():
			ability.update(delta)
