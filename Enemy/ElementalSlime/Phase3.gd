extends EnemyPhaseState

var FireSprial = preload("res://Enemy/ElementalSlime/Abilities/Firespiral.tscn").instantiate()
var EngulfingPlain = preload("res://Enemy/ElementalSlime/Abilities/EngulfingPlain.tscn").instantiate()
var Fireball = preload("res://Combat/abilities/Fireball.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	owner.add_child(FireSprial)
	owner.add_child(EngulfingPlain)
	owner.add_child(Fireball)
	add_timed_ability_sequence([
		TimedAbility.new(EngulfingPlain, Globals.get_player(), 0.0, 0.0),
		TimedAbility.new(Fireball, Globals.get_player(), 3.0, 3.0),
		TimedAbility.new(FireSprial, Globals.get_player(), 5.0, 5.0),
		TimedAbility.new(Fireball, Globals.get_player(), 20.0, 20.0),
	], 5.0, 5.0, 100.0, 3.0)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
