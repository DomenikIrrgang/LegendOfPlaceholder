extends UnitState

func _ready() -> void:
	super()
	movement_strategy = UnitMovementStrategy.new(unit)

func enter(_data := {}) -> void:
	super()
	unit.casting_enabled = false
	unit.status_effect_updates_enabled = false
	update_animation()
	
func exit() -> void:
	unit.casting_enabled = true
	unit.status_effect_updates_enabled = true
	
func update(delta: float) -> void:
	update_animation()

func update_animation() -> void:
	print(unit.movement_velocity, Unit.Direction.keys()[unit.direction])
	if unit.movement_velocity == Vector2(0, 0):
		match (unit.direction):
			Unit.Direction.LEFT:
				unit.set_animation(unit.model_instance.get_idle_left_animation())
			Unit.Direction.RIGHT:
				unit.set_animation(unit.model_instance.get_idle_right_animation())
			Unit.Direction.DOWN:
				unit.set_animation(unit.model_instance.get_idle_down_animation())
			Unit.Direction.UP:
				unit.set_animation(unit.model_instance.get_idle_up_animation())
	else:
		match (unit.direction):
			Unit.Direction.LEFT:
				unit.set_animation(unit.model_instance.get_left_animation())
			Unit.Direction.RIGHT:
				unit.set_animation(unit.model_instance.get_right_animation())
			Unit.Direction.DOWN:
				unit.set_animation(unit.model_instance.get_down_animation())
			Unit.Direction.UP:
				unit.set_animation(unit.model_instance.get_up_animation())
