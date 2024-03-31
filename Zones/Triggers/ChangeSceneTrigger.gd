class_name ChangeSceneTrigger
extends Trigger

@export_file
var scene: String

@export
var spawm_position: Vector2

func trigger() -> void:
	SceneSwitcher.load_scene(scene, spawm_position)
