extends Node

var loading_scene: bool = false

signal zone_loaded(scene: Zone)

func _ready() -> void:
	SaveFileManager.save_file_loaded.connect(on_load)
	SaveFileManager.save_file_saving.connect(on_save)
	
func on_save(save_file: Dictionary) -> void:
	save_file.current_scene = Globals.get_world().get_children()[0].scene_file_path if Globals.get_world().get_children().size() > 0 else "res://Zones/ForestGrove/ForestGrove.tscn"
	save_file.player_position = {
		x = Globals.get_player().global_position.x,
		y = Globals.get_player().global_position.y
	}
	
func on_load(save_file: Dictionary) -> void:
	load_scene(
		save_file.current_scene,
		Vector2(save_file.player_position.x, save_file.player_position.y)
	)
	
func load_scene(path: String, spawn_position: Vector2) -> void:
	call_deferred("defered_load_scene", path, spawn_position)
	loading_scene = true
	
func defered_load_scene(path: String, spawn_position: Vector2) -> void:
	Globals.get_loading_screen().take_screenshot()
	for child in Globals.get_world().get_children():
		child.queue_free()
	var scene = ResourceLoader.load(path)
	var scene_instance = scene.instantiate()
	scene_instance.tree_entered.connect(on_scene_loaded)
	Globals.get_world().request_ready()
	if !Globals.get_world().ready.is_connected(on_scene_loaded):
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
