class_name OppositeDirectionMovementStrategy
extends UnitMovementStrategy

var player: Player

func _init(_unit: Unit, _player: Player):
	super(_unit)
	player = _player
	player.direction_changed.connect(player_direction_changed)
	
func calculateMovementVelocity() -> Vector2:
	return player.velocity * -1

func player_direction_changed(direction: int) -> void:
	pass
