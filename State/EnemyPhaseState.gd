class_name EnemyPhaseState
extends State

var timers = []
var sequences = []

func add_timed_ability(ability: Ability, target, cooldown_min: float, cooldown_max: float, activation_chance: float = 100.0, initial_time_passed: float = 0.0) -> void:
	timers.append({
		"callback": func() -> bool:
			return get_enemy().use_ability(target if target is Unit else target.call(), ability),
		"cooldown_min": cooldown_min,
		"cooldown_max": cooldown_max,
		"time_passed": initial_time_passed,
		"activation_chance": activation_chance
	})
	get_enemy().abilities.append(ability)
	
func add_timed_ability_sequence(sequence: Array[TimedAbility], cooldown_min: float, cooldown_max: float, activation_chance: float = 100.0, initial_time_passed: float = 0.0) -> void:
	sequences.append({
		"sequence": sequence,
		"cooldown_min": cooldown_min,
		"cooldown_max": cooldown_max,
		"time_passed": initial_time_passed,
		"activation_chance": activation_chance,
		"started": false,
	})
	
func get_enemy() -> Enemy:
	return owner

func add_timed_function(callback: Callable, cooldown_min: float, cooldown_max: float, activation_chance: float = 100.0, initial_time_passed: float = 1.0) -> void:
	timers.append({
		"callback": callback,
		"cooldown_min": cooldown_min,
		"cooldown_max": cooldown_max,
		"time_passed": initial_time_passed,
		"activation_chance": activation_chance,
		"start_timed": 0.0,
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
	for sequence in sequences:
		sequence.time_passed += delta
		if sequence.cooldown_min <= sequence.time_passed:
			if sequence.started == false and Globals.random_chance(sequence.activation_chance * delta):
				sequence.started = true
				sequence.start_time = sequence.time_passed
			if sequence.started == false and sequence.cooldown_max <= sequence.time_passed:
				sequence.started = true
				sequence.start_time = sequence.time_passed
			if sequence.started == true:
				var all_abilities_executed = true
				for timed_ability in sequence.sequence:
					if timed_ability.cooldown_min <= sequence.time_passed - sequence.start_time:
						if timed_ability.executed == false and Globals.random_chance(timed_ability.activation_chance * delta):
							if get_enemy().use_ability(timed_ability.target, timed_ability.ability):
								timed_ability.executed = true
					if timed_ability.executed == false and timed_ability.cooldown_max <= sequence.time_passed - sequence.start_time:				
						if get_enemy().use_ability(timed_ability.target, timed_ability.ability):
							timed_ability.executed = true
					if timed_ability.executed == false:
						all_abilities_executed = false
				if all_abilities_executed:
					sequence.started = false
					sequence.time_passed = 0.0
					sequence.start_time = 0.0
					for timed_ability in sequence.sequence:
						timed_ability.executed = false
					

func enter(_data = {}) -> void:
	super()
			
func exit() -> void:
	super()
	get_enemy().abilities.clear()
	get_enemy().stop_casting()
	timers.clear()
	sequences.clear()

func spawn_enemy(enemy: Enemy, position: Vector2) -> Enemy:
	get_enemy().get_parent().add_child(enemy)
	enemy.global_position = position
	return enemy
