extends EnemyPhaseState

var MendBoss = preload("res://Combat/abilities/Mend.tscn").instantiate()

func enter(data = {}) -> void:
	super(data)
	MendBoss.cooldown = 0
	add_timed_ability(MendBoss, func(): return get_enemy().heal_target if get_enemy().heal_target != null else get_enemy(), 8.0, 10.0, 20.0)
	

