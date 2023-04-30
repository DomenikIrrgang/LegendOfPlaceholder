extends EnemyPhaseState

func _ready() -> void:
	super()
	add_timed_function(spawn_slime, 12.0, 18.0, 20.0)
	
func enter(_data := {}) -> void:
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(boss_health_changed)
	
func exit() -> void:
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.disconnect(boss_health_changed)
	
func spawn_slime() -> void:
	var slime = preload("res://Enemy/Slime/Slime.tscn").instantiate()
	var player = Globals.get_player()
	var enemy = get_enemy()
	enemy.add_child(slime)
	slime.global_position = enemy.global_position + player.global_position.direction_to(enemy.global_position).normalized().rotated(0.5 * PI) * 30
	enemy.resource_link.add_unit(slime)
	
func boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	if resource.get_percentage() <= 0.7:
		state_machine.transition_to("Phase2")
