extends EnemyPhaseState

func enter(_data = {}) -> void:
	add_timed_function(increase_movement_speed, 1.0, 1.0, 100.0)
	get_enemy().get_node("State/Moving").movement_strategy = FollowMovementStrategy.new(owner, Globals.get_player())
	get_enemy().get_node("State/Idle").movement_strategy = FollowMovementStrategy.new(owner, Globals.get_player())
	
func increase_movement_speed() -> bool:
	get_enemy().stats.increase_stat(Stat.Enum.MOVEMENT_SPEED, 1.0)
	return true
	
