extends Node

var inventory: Inventory = Inventory.new(32)
var bank: Inventory = Inventory.new(128)

func _ready() -> void:
	SaveFileManager.save_file_saving.connect(on_save)
	SaveFileManager.save_file_loaded.connect(on_load)
	SaveFileManager.save_file_start_loading.connect(reset)
	
func reset() -> void:
	inventory.empty()
	bank.empty()
	get_player().set_level(1)
	get_player().set_experience(0)
	
func on_save(save_file: Dictionary) -> void:
	save_file.inventory = get_inventory_save(inventory)
	save_file.bank = get_inventory_save(bank)
	save_file.player = {
		experience = get_player().get_total_experience()
	}
	
func on_load(save_file: Dictionary) -> void:
	get_player().gain_experience(save_file.player.experience)
	load_inventory(inventory, save_file.inventory)
	load_inventory(bank, save_file.bank)
	
func get_inventory_save(_inventory: Inventory) -> Array:
	return _inventory.slots.map(func(slot: InventorySlot):
		return {
			item = SaveFileManager.get_resource_uid(slot.item) if slot.item != null else null,
			amount = slot.amount
		}
	)

func load_inventory(_inventory: Inventory, data: Array):
	for index in range(data.size()):
		if data[index].item != null:
			_inventory.change_slot(index, SaveFileManager.get_resource_from_uid(data[index].item), data[index].amount)
	
func get_unit(unit_name: String) -> Unit:
	var scene_treer_root = get_scene_tree().root
	var root_node = get_scene_tree().root.get_child(scene_treer_root.get_child_count() - 1)
	var unit = root_node.find_child(unit_name)
	if unit == null:
		unit = get_world().get_child(0).find_child(unit_name)
	return unit
	
func get_inventory() -> Inventory:
	return inventory
	
func get_bank() -> Inventory:
	return bank

func get_loaded_scene_node() -> Node2D:
	return get_world().get_child(0)
	
func get_enemies() -> Array[Node]:
	return get_scene_tree().get_nodes_in_group("enemy")

func get_player() -> Player:
	return get_scene_tree().get_first_node_in_group("player")
	
func get_environment_light() -> EnvironmentLighting:
	return get_scene_tree().get_first_node_in_group("environmentlight")
	
func get_camera() -> Camera2D:
	return get_scene_tree().get_first_node_in_group("camera")
	
func get_background_music_player() -> AudioStreamPlayer:
	return get_scene_tree().get_first_node_in_group("BackgroundMusic")
	
func get_sound_effects_player() -> AudioStreamPlayer:
	return get_scene_tree().get_first_node_in_group("SoundEffects")
	
func get_loading_screen() -> CanvasLayer:
	return get_scene_tree().get_first_node_in_group("loadingscreen")
	
func get_world() -> Node2D:
	return get_scene_tree().get_first_node_in_group("world")
	
func get_user_interface() -> CanvasLayer:
	return get_scene_tree().get_first_node_in_group("UserInterfaceCanvas")
	
func get_game_user_inteface() -> Control:
	return get_user_interface().get_node("GameUI")

func get_drag_and_drop() -> DragAndDrop:
	return get_game_user_inteface().get_node("DragAndDrop")
	
func get_dialogs_node() -> Control:
	return get_user_interface().get_node("Dialogs")
	
func get_cutescene_bars() -> Control:
	return get_user_interface().get_node("CutsceneBars")

func get_scene_tree() -> SceneTree:
	return get_tree()

func random_chance(chance: float) -> bool:
	return (randf() * 100.0) <= chance
	
func start_enemies() -> void:
	var enemies = get_scene_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.start()
		
func pause_enemies() -> void:
	var enemies = get_scene_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.pause()

func start_units() -> void:
	var enemies = get_scene_tree().get_nodes_in_group("unit")
	for enemy in enemies:
		enemy.start()

func pause_units() -> void:
	var enemies = get_scene_tree().get_nodes_in_group("unit")
	for enemy in enemies:
		enemy.pause()

# min and max have to be between 0.0 and 1.0	
func random_value(minimum: float, maximum: float) -> float:
	return randf() * (maximum - minimum) + minimum
	
func get_first_collision(world: World2D, source: Vector2, target: Vector2, exclude: Array) -> Vector2:
	var space_state = world.direct_space_state
	var query = PhysicsRayQueryParameters2D.create(source, target)
	query.exclude = exclude
	var result = space_state.intersect_ray(query)
	if result:
		return result.position - (target - source).normalized() * 3
	return target
	
func get_units_around_unit(source: Unit, radius: float, execlude: Array[Unit] = []) -> Array[Unit]:
	var result: Array[Unit] = []
	for target in get_scene_tree().get_nodes_in_group("unit"):
		var distance = (source.global_position - target.global_position).length()
		if distance <= radius and target != source and not execlude.has(target):
			result.append(target)
	return result

func spawn_unit(unit: Unit, position: Vector2) -> Unit:
	Globals.get_world().add_child(unit)
	unit.global_position = position
	return unit

func get_closest_enemy() -> Enemy:
	var enemy: Enemy
	for node in get_scene_tree().get_nodes_in_group("enemy"):
		if enemy == null:
			enemy = node
		if get_player().global_position.distance_to(node.global_position) < get_player().global_position.distance_to(enemy.global_position):
			enemy = node
	return enemy
