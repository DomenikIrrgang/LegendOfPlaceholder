extends Node2D

@onready
var version: Label = $CanvasLayer/HBoxContainer/MarginContainer/Version

func _ready():
	version.text = "version " + ProjectSettings.get_setting("application/config/version")
	Globals.get_user_interface().visible = false
	SceneSwitcher.load_scene("res://Zones/ForestGrove/ElementalSlimeArena.tscn", Vector2(18, 52))
	Globals.get_player().pause()
	Globals.get_player().walk_to_position([Vector2(18, 52), Vector2(142, 52), Vector2(142, -58), Vector2(18, -58)])

func _physics_process(delta):
	if Globals.get_player().global_position.distance_to(Vector2(18, -58)) <= 0.5:
		Globals.get_player().walk_to_position([Vector2(18, 52), Vector2(142, 52), Vector2(142, -58), Vector2(18, -58)])
