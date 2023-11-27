class_name CircularTelegraph
extends Node2D

@export
var radius: int

var texture_width: int = 32

func set_radius(_radius: int) -> void:
	radius = _radius
	var ratio = radius / (float(texture_width) / 2.0)
	scale.x = ratio
	scale.y = ratio
