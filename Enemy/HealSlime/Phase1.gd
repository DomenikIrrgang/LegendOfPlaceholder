extends EnemyPhaseState

var MendBoss = preload("res://Combat/abilities/Mend.tscn").instantiate()

func enter(data = {}) -> void:
	super(data)
	MendBoss.cooldown = 0
	MendBoss.cast_time = 8.0
	add_timed_ability(MendBoss, func(): return get_enemy().heal_target if get_enemy().heal_target != null else get_enemy(), 1.0, 1.0, 100.0)
	

