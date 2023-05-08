extends Node

var loading_scene: bool = false

signal zone_loaded(scene: Zone)

func load_scene(path: String, spawn_position: Vector2) -> void:
	call_deferred("defered_load_scene", path, spawn_position)
	loading_scene = true
	
func defered_load_scene(path: String, spawn_position: Vector2) -> void:
	Globals.get_loading_screen().take_screenshot()
	for child in Globals.get_world().get_children():
		child.free()
	var scene = ResourceLoader.load(path)
	var scene_instance = scene.instantiate()
	scene_instance.tree_entered.connect(on_scene_loaded)
	Globals.get_world().request_ready()
	Globals.get_world().ready.connect(on_scene_loaded)
	Globals.get_world().add_child(scene_instance)
	Globals.get_player().global_position = spawn_position
	Globals.get_camera().global_position = spawn_position
	Globals.get_camera().reset_smoothing()
	zone_loaded.emit(scene_instance)
	

func on_scene_loaded() -> void:
	loading_scene = false
	
func is_loading_scene() -> bool:
	return loading_scene
