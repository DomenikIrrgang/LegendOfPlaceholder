extends Node

func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")

func get_scene_tree() -> SceneTree:
	return get_tree()

func random_chance(chance: float) -> bool:
	return (randf() * 100.0) <= chance

# min and max have to be between 0.0 and 1.0	
func random_value(minimum: float, maximum: float) -> float:
	return randf() * (maximum - minimum) + minimum
