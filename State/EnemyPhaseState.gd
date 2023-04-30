class_name EnemyPhaseState
extends State

var timers = []

func add_timed_ability(ability: Ability, target, cooldown_min: float, cooldown_max: float, activation_chance: float = 100.0) -> void:
	timers.append({
		"callback": func() -> bool:
			return get_enemy().use_ability(target if target is Unit else target.call(), ability),
		"cooldown_min": cooldown_min,
		"cooldown_max": cooldown_max,
		"time_passed": 0.0,
		"activation_chance": activation_chance
	})
	get_enemy().abilities.append(ability)

func add_timed_function(callback: Callable, cooldown_min: float, cooldown_max: float, activation_chance: float = 100.0) -> void:
	timers.append({
		"callback": callback,
		"cooldown_min": cooldown_min,
		"cooldown_max": cooldown_max,
		"time_passed": 0.0,
		"activation_chance": activation_chance
	})
	
func update(delta: float) -> void:
	for timer in timers:
		timer.time_passed += delta
		if timer.cooldown_min <= timer.time_passed:
			if Globals.random_chance(timer.activation_chance * delta):
				var executed = timer.callback.call()
				if executed:
					timer.time_passed = 0.0
		if timer.cooldown_max <= timer.time_passed:
			var executed = timer.callback.call()
			if executed:
				timer.time_passed = 0.0

func enter(data = {}) -> void:
	super()
			
func exit() -> void:
	super()
	get_enemy().abilities.clear()
	get_enemy().stop_casting()
	timers.clear()
			
