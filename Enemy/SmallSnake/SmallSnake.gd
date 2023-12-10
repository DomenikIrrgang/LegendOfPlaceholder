class_name SmallSnake
extends Enemy

@onready
var phase1: EnemyPhaseState = $StateMachine/Phase1

func _process(delta: float) -> void:
	super(delta)
	if movement_velocity.x == 0:
		self.model_animation.play("Idle")
	if movement_velocity.x < 0:
		self.model_animation.play("Left")
	if movement_velocity.x > 0:
		self.model_animation.play("Right")

func add_ability(ability: Ability, target, cooldown_min: float, cooldown_max: float, activation_chance: float = 100.0, initial_time_passed: float = 0.0) -> void:
	phase1.add_timed_ability(ability, target, cooldown_min, cooldown_max, activation_chance, initial_time_passed)
