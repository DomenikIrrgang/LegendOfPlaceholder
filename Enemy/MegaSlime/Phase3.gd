extends EnemyPhaseState

var SummonSlime = preload("res://Enemy/MegaSlime/Abilities/SummonSlime.tscn").instantiate()
var SummonHealSlime = preload("res://Enemy/MegaSlime/Abilities/SummonHealSlime.tscn").instantiate()
var Zone = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoom.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	add_timed_ability(SummonSlime, Globals.get_player(), 10.0, 17.0, 20.0)
	add_timed_ability(SummonHealSlime, Globals.get_player(), 22.0, 28.0, 20.0)
	add_timed_ability(Zone, Globals.get_player(), 8.0, 12.0, 20.0)
	Globals.get_player().teleport(Vector2(-60, -5))
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(boss_health_changed)
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaSlimePhase3.tres"))

func boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	if resource.get_percentage() <= 0.4:
		state_machine.transition_to("Phase4")
