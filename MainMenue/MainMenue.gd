extends Node2D

@onready
var version: Label = $CanvasLayer/Theme/LeftFooter/MarginContainer/Version

@onready
var game_state_one = $CanvasLayer/Theme/CenterContainer/VBoxContainer/GameState1

func _ready():
	version.text = "version " + ProjectSettings.get_setting("application/config/version")
	Globals.get_user_interface().visible = false
	SceneSwitcher.load_scene("res://Zones/ForestGrove/ElementalSlimeArena.tscn", Vector2(18, 52))
	Globals.get_player().pause()
	Globals.get_player().walk_to_position([Vector2(18, 52), Vector2(142, 52), Vector2(142, -58), Vector2(18, -58)])
	game_state_one.grab_focus()

func _physics_process(_delta: float) -> void:
	if Globals.get_player().global_position.distance_to(Vector2(18, -58)) <= 0.5:
		Globals.get_player().walk_to_position([Vector2(18, 52), Vector2(142, 52), Vector2(142, -58), Vector2(18, -58)])
