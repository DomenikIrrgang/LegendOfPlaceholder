extends EnemyPhaseState

var SummonSlime = preload("res://Enemy/MegaSlime/Abilities/SummonSlime.tscn").instantiate()
var SummonHealSlime = preload("res://Enemy/MegaSlime/Abilities/SummonHealSlime.tscn").instantiate()
var Zone = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoom.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	get_enemy().movement_strategy = FollowMovementStrategy.new(get_enemy(), Globals.get_player())
	add_timed_ability(SummonSlime, Globals.get_player(), 10.0, 17.0, 20.0)
	add_timed_ability(SummonHealSlime, Globals.get_player(), 22.0, 28.0, 20.0)
	add_timed_ability(Zone, Globals.get_player(), 8.0, 12.0, 20.0)

func on_slime_died(_slime: Unit) -> void:
	pass
