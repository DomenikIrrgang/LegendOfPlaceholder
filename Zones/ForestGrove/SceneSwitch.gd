extends Area2D

@export_file
var scene: String

@export
var spawm_position: Vector2

func _ready() -> void:
	area_entered.connect(on_area_entered)
	
func on_area_entered(area) -> void:
	if area.owner is Player:
		SceneSwitcher.load_scene(scene, spawm_position)
