extends Node

func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")

func get_scene_tree() -> SceneTree:
	return get_tree()
