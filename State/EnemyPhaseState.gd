class_name EnemyPhaseState
extends State

var timers = []

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
			var chance = timer.activation_chance * delta
			if Globals.random_chance(timer.activation_chance * delta):
				timer.callback.call()
				timer.time_passed = 0.0
		if timer.cooldown_max <= timer.time_passed:
			timer.callback.call()
			timer.time_passed = 0.0
			
