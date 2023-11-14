extends EnemyPhaseState

var FireSprial = preload("res://Enemy/ElementalSlime/Abilities/Firespiral.tscn").instantiate()
var EngulfingPlain = preload("res://Enemy/ElementalSlime/Abilities/EngulfingPlain.tscn").instantiate()
var Fireball = preload("res://Combat/abilities/Fireball.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	owner.add_child(FireSprial)
	owner.add_child(EngulfingPlain)
	owner.add_child(Fireball)
	add_timed_ability(Fireball, Globals.get_player(), 5.0, 5.0)
	add_timed_ability_sequence([
		TimedAbility.new(EngulfingPlain, Globals.get_player(), 0.0, 0.0),
		TimedAbility.new(Fireball, Globals.get_player(), 5.0, 5.0),
		TimedAbility.new(Fireball, Globals.get_player(), 10.0, 10.0)
	], 20.0, 20.0, 100.0, 20.0)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(boss_health_changed)

func boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	if resource.get_percentage() <= 0.5:
		state_machine.transition_to("Phase3")
