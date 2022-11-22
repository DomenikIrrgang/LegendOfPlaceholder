class_name CustomCamera
extends Camera2D

@export
var targeted_node: Node2D

func _process(_delta: float) -> void:
	self.position = targeted_node.position
