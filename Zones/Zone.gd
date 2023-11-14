class_name Zone
extends Node2D

@export
var zone_name: String

@export
var environment_light_energy: float

func _ready():
	Globals.get_environment_light().change_energy(environment_light_energy, 0.0)
