extends PlayerState

var movement_strategy: UnitMovementStrategy

func enter(_data := {}) -> void:
	if movement_strategy == null:
		movement_strategy = UnitMovementStrategy.new(player)
	player.movement_strategy = movement_strategy
	player.casting_enabled = false
	player.status_effect_updates_enabled = false
	update_animation()
	
func exit() -> void:
	player.casting_enabled = true
	player.status_effect_updates_enabled = true

func update_animation() -> void:
	match (player.direction):
		Unit.Direction.LEFT:
			player.set_animation("Idle_Left")
		Unit.Direction.RIGHT:
			player.set_animation("Idle_Right")
		Unit.Direction.DOWN:
			player.set_animation("Idle_Down")
		Unit.Direction.UP:
			player.set_animation("Idle_Up")
