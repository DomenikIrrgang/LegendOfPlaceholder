extends Node

var Circular_TeleGraph = load("res://Combat/CircularTelegraph.tscn")

func show_circular_telegraph(radius: int, position: Vector2) -> CircularTelegraph:
	var telegraph = Circular_TeleGraph.instantiate()
	Globals.get_world().add_child(telegraph)
	telegraph.global_position = position
	telegraph.set_radius(radius)
	return telegraph
