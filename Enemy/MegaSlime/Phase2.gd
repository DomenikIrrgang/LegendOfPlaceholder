extends EnemyPhaseState

func _ready() -> void:
	super()
	add_timed_function(spawn_slime, 12.0, 18.0, 20.0)
	add_timed_function(spawn_heal_slime, 22.0, 28.0, 20.0)
	add_timed_function(zone_of_doom, 8.0, 12.0, 20.0)
	
func enter(_data := {}) -> void:
	super(_data)
	get_enemy().movement_strategy = FollowMovementStrategy.new(get_enemy(), Globals.get_player())
	
func spawn_slime() -> void:
	var slime = preload("res://Enemy/Slime/Slime.tscn").instantiate()
	var player = Globals.get_player()
	var enemy = get_enemy()
	enemy.get_parent().add_child(slime)
	slime.died.connect(on_slime_died)
	slime.global_position = enemy.global_position + player.global_position.direction_to(enemy.global_position).normalized().rotated(0.5 * PI) * 30
	enemy.resource_link.add_unit(slime)
	
func spawn_heal_slime() -> void:
	var heal_slime = preload("res://Enemy/HealSlime/HealSlime.tscn").instantiate()
	var player = Globals.get_player()
	var enemy = get_enemy()
	enemy.get_parent().add_child(heal_slime)
	heal_slime.set_heal_target(get_enemy())
	heal_slime.global_position = enemy.global_position + player.global_position.direction_to(enemy.global_position).normalized() * 30
	
func zone_of_doom() -> void:
	spawn_zone(Globals.get_player().global_position + Vector2(randi_range(-15, 15), randi_range(-15, 15)))

func spawn_zone(location: Vector2) -> void:
	var zone = preload("res://Combat/abilities/ZoneOfDoom.tscn").instantiate()
	zone.source = get_enemy()
	get_enemy().get_parent().add_child(zone)
	zone.global_position = location
	
func on_slime_died(slime: Unit) -> void:
	spawn_zone(slime.global_position)
