extends Node

var loading_scene: bool = false

const STARTING_ZONE: String = "res://Zones/ForestGrove/RemsHouse/RemsRoom.tscn"

signal zone_loaded(scene: Zone)

func _ready() -> void:
	SaveFileManager.game_state_loaded.connect(on_load)
	SaveFileManager.game_state_saving.connect(on_save)
	
func on_save(game_state: Dictionary) -> void:
	if SaveFileManager.is_first_game_state_save():
		game_state.current_scene = STARTING_ZONE
		game_state.player_position = {
			x = 0.0,
			y = 0.0
		}
	else:
		game_state.current_scene = Globals.get_world().get_children()[0].scene_file_path if Globals.get_world().get_children().size() > 0 else STARTING_ZONE
		game_state.player_position = {
			x = Globals.get_player().global_position.x,
			y = Globals.get_player().global_position.y
		}
	
func on_load(game_state: Dictionary) -> void:
	load_scene(
		game_state.current_scene,
		Vector2(game_state.player_position.x, game_state.player_position.y)
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
