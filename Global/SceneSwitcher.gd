extends Node

var current_scene = null
var loading_scene: bool = false

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func load_scene(path: String, spawn_position: Vector2) -> void:
	call_deferred("defered_load_scene", path, spawn_position)
	loading_scene = true
	
func defered_load_scene(path: String, spawn_position: Vector2) -> void:
	current_scene.free()
	var scene = ResourceLoader.load(path)
	current_scene = scene.instantiate()
	current_scene.tree_entered.connect(on_scene_loaded)
	Globals.get_scene_tree().root.add_child(current_scene)
	Globals.get_scene_tree().current_scene = current_scene
	Globals.get_player().global_position = spawn_position

func on_scene_loaded() -> void:
	loading_scene = false
	
func is_loading_scene() -> bool:
	return loading_scene
