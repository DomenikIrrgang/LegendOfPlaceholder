class_name PlayerCloseToNodeGroupCondition
extends Condition

@export
var node_group: String

@export
var distance: float = 15.0

func is_fulfilled() -> bool:
	var nodes = Globals.get_nodes_around_unit_in_group(node_group, Globals.get_player(), distance)
	return nodes.size() > 0
	
func get_string() -> String:
	return "Needs to be close to " + node_group
