extends EnemyPhaseState

var SummonSlime = preload("res://Enemy/MegaSlime/Abilities/SummonSlime.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	add_timed_ability(SummonSlime, func(): return Globals.get_player(), 9.0, 15.0, 20.0)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(boss_health_changed)
	
func exit() -> void:
	super()
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.disconnect(boss_health_changed)
	
func boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	if resource.get_percentage() <= 0.7:
		state_machine.transition_to("Phase2")
