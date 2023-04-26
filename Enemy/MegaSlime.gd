class_name MegaSlime
extends Enemy

var slime_cooldown: float = 8
var last_slime_spawn_time: float

var zone_cooldown: float = 10
var last_zone_spawn: float

func _ready() -> void:
	super()
	movement_strategy = UnitMovementStrategy.new(self)
	died.connect(on_mega_slime_died)

func _process(delta: float) -> void:
	super(delta)
	if Time.get_unix_time_from_system() - last_slime_spawn_time > slime_cooldown:
		spawn_slime()
	if Time.get_unix_time_from_system() - last_zone_spawn > zone_cooldown and get_resource(ResourceType.Enum.HEALTH).get_percentage() < 0.9:
		spawn_zone()
	if get_resource(ResourceType.Enum.HEALTH).get_percentage() < 0.5 and not movement_strategy is FollowMovementStrategy:
		movement_strategy = FollowMovementStrategy.new(self, get_node("../Player"))
	
func spawn_slime() -> void:
	last_slime_spawn_time = Time.get_unix_time_from_system()
	var slime = preload("res://Enemy/Slime.tscn").instantiate()
	get_parent().add_child(slime)
	slime.global_position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
	
func spawn_zone() -> void:
	last_zone_spawn = Time.get_unix_time_from_system()
	var zone = preload("res://Combat/abilities/ZoneOfDoom.tscn").instantiate()
	zone.source = self
	var player = get_node("../Player")
	get_parent().add_child(zone)
	zone.global_position = player.global_position + Vector2(randi_range(-15, 15), randi_range(-15, 15))

func on_mega_slime_died() -> void:
	for i in 20:
		spawn_slime()
	
