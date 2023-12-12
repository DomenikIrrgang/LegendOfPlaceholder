extends PlayerState

var movement_strategy: UnitMovementStrategy

func update(_delta: float) -> void:
	update_animation()
	if (player.movement_velocity == Vector2.ZERO):
		state_machine.transition_to("Idle")
		
func enter(_data := {}) -> void:
	print("entered running state")
	if movement_strategy == null:
		movement_strategy = ControlledMovementStrategy.new(Globals.get_player())
	print("movement_strategy_enabled ", movement_strategy.enabled)
	print("movement_strategy", movement_strategy)
	player.movement_strategy = movement_strategy
	
func update_animation() -> void:
	match (player.direction):
		Player.Direction.LEFT:
			player.set_animation("Left")
		Player.Direction.RIGHT:
			player.set_animation("Right")
		Player.Direction.DOWN:
			player.set_animation("Down")
		Player.Direction.UP:
			player.set_animation("Up")
