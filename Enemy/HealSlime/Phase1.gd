extends EnemyPhaseState

var mend: Mend

func _ready() -> void:
	super()
	add_timed_function(heal_target, 8.0, 10.0, 20.0)

func enter(_data := {}) -> void:
	mend = load("res://Combat/abilities/Mend.tscn").instantiate()
	mend.cooldown = 0.0
	get_enemy().movement_strategy = EscapeMovementStrategy.new(get_enemy(), Globals.get_player())
	
func heal_target() -> void:
	CombatLogic.cast_ability(mend, get_enemy(), get_enemy().heal_target)
	

