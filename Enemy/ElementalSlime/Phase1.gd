extends EnemyPhaseState

var FireSprial = preload("res://Enemy/ElementalSlime/Abilities/Firespiral.tscn").instantiate()
var EngulfingPlain = preload("res://Enemy/ElementalSlime/Abilities/EngulfingPlain.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	owner.add_child(FireSprial)
	owner.add_child(EngulfingPlain)
	#add_timed_ability(FireSprial, func(): return Globals.get_player(), 20.0, 20.0, 20.0)
	#wadd_timed_ability(EngulfingPlain, func(): return Globals.get_player(), 20.0, 20.0, 20.0)
	add_timed_ability_sequence([
		TimedAbility.new(EngulfingPlain, Globals.get_player(), 0.0, 0.0),
		TimedAbility.new(FireSprial, Globals.get_player(), 5.0, 5.0),
	], 20.0, 20.0)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
