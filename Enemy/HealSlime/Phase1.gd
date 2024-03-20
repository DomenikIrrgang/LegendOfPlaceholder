extends EnemyPhaseState

var MendBoss = preload("res://Combat/abilities/Mend.tscn").instantiate()

func enter(data = {}) -> void:
	super(data)
	MendBoss.cooldown = 0
	MendBoss.cast_time = 8.0
	get_enemy().get_node("State/Moving").movement_strategy = EscapeMovementStrategy.new(get_enemy(), Globals.get_player())
	get_enemy().get_node("State/Idle").movement_strategy = EscapeMovementStrategy.new(get_enemy(), Globals.get_player())
	get_enemy().get_node("State/Casting").movement_strategy = EscapeMovementStrategy.new(get_enemy(), Globals.get_player())
	add_timed_ability(MendBoss, func(): return get_enemy().heal_target if get_enemy().heal_target != null else get_enemy(), 8.0, 8.0, 100.0, 10.0)
	

