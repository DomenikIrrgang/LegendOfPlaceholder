class_name MegaSlime
extends Enemy

var slime_cooldown: float = 14
var last_slime_spawn_time: float = Time.get_unix_time_from_system()

var heal_slime_cooldown: float = 25
var last_heal_slime_spawn_time: float = Time.get_unix_time_from_system()

var zone_cooldown: float = 10
var last_zone_spawn: float

var phase_2_start: float = 0.7

var player: Player
var space_state

var resource_link: ResourceLink

func _ready() -> void:
	super()
	movement_strategy = UnitMovementStrategy.new(self)
	player = get_tree().get_first_node_in_group("player")
	died.connect(on_mega_slime_died)
	space_state = get_world_2d().direct_space_state
	resource_link = ResourceLink.new(ResourceType.Enum.HEALTH, [self])

func _process(delta: float) -> void:
	super(delta)
	if Time.get_unix_time_from_system() - last_slime_spawn_time > slime_cooldown:
		spawn_slime()
	if Time.get_unix_time_from_system() - last_heal_slime_spawn_time > heal_slime_cooldown:
		spawn_heal_slime()
	if Time.get_unix_time_from_system() - last_zone_spawn > zone_cooldown and get_resource(ResourceType.Enum.HEALTH).get_percentage() <phase_2_start:
		spawn_zone(player.global_position + Vector2(randi_range(-15, 15), randi_range(-15, 15)))
	if get_resource(ResourceType.Enum.HEALTH).get_percentage() < phase_2_start and not movement_strategy is FollowMovementStrategy:
		movement_strategy = FollowMovementStrategy.new(self, get_node("../Player"))
	
func spawn_slime(location: Vector2 = Vector2.ZERO) -> void:
	last_slime_spawn_time = Time.get_unix_time_from_system()
	var slime = preload("res://Enemy/Slime.tscn").instantiate()
	get_parent().add_child(slime)
	slime.died.connect(on_slime_died)
	var slime_position = location if location != Vector2.ZERO else player.global_position + global_position.direction_to(player.global_position).normalized() * 30
	if location == Vector2.ZERO:
		var query = PhysicsRayQueryParameters2D.create(
			player.global_position + player.global_position.direction_to(slime_position).normalized(),
			slime_position)
		query.collide_with_bodies = true
		var result = space_state.intersect_ray(query)
		if result:
			slime_position = result.position + result.position.direction_to(global_position) * 12
	slime.global_position = slime_position
	resource_link.add_unit(slime)
	
func spawn_heal_slime() -> void:
	last_heal_slime_spawn_time = Time.get_unix_time_from_system()
	var slime = preload("res://Enemy/HealSlime.tscn").instantiate()
	get_parent().add_child(slime)
	slime.died.connect(on_slime_died)
	slime.set_heal_target(self)
	slime.global_position = global_position + player.global_position.direction_to(global_position).normalized() * 30
	
func spawn_zone(location: Vector2) -> void:
	last_zone_spawn = Time.get_unix_time_from_system()
	var zone = preload("res://Combat/abilities/ZoneOfDoom.tscn").instantiate()
	zone.source = self
	get_parent().add_child(zone)
	zone.global_position = location

func on_slime_died(slime: Unit) -> void:
	if get_resource(ResourceType.Enum.HEALTH).get_percentage() < phase_2_start:
		var zone = preload("res://Combat/abilities/ZoneOfDoom.tscn").instantiate()
		zone.source = self
		get_parent().add_child(zone)
		zone.global_position = slime.global_position

func on_mega_slime_died(mega_slime: Unit) -> void:
	for i in 20:
		spawn_slime(mega_slime.global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20)))
	
