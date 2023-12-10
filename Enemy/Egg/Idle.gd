extends EnemyPhaseState


func enter(_data := {}) -> void:
	super(_data)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
