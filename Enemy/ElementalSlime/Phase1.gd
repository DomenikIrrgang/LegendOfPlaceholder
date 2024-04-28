extends EnemyPhaseState

var Fireball = preload("res://Combat/abilities/Fireball.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	owner.add_child(Fireball)
	add_timed_ability(Fireball, Globals.get_player() if Globals.get_player() != null else get_enemy(), 5.0, 5.0)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(boss_health_changed)

func boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	if resource.get_percentage() <= 0.9:
		state_machine.transition_to("Phase2")
