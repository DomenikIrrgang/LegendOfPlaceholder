class_name Unit
extends CharacterBody2D

var DamageNumberComponent = preload("res://ui/unit/DamageNumber.tscn")

@export
var unit_data: UnitData

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

# Base Stats
var max_level: int = 60

var stat_calculator: StatCalculator
var base_stats: StatSet
var stats: StatSet

signal stat_changed(stat: Stat, new_value: int)
signal level_changed(level: int)

# Movement
var pushback_velocity: Vector2 = Vector2(0, 0)
var last_pushback: float = 0.0
var pushback_cooldown: float = 0.3

var movement_velocity: Vector2 = Vector2(0, 0)
var movement_strategy: UnitMovementStrategy :
	set(value):
		movement_strategy = value
	
var movement_modifiers: Array[MovementModifier] = []

# Resources
var resources: Array[UnitResource] = []

signal unit_resource_added(resource: ResourceType.Enum)
signal unit_resource_removed(resource: ResourceType.Enum)

func get_resources() -> Array[UnitResource]:
	return resources

func get_secondary_resource_type() -> ResourceType.Enum:
	for resource in resources:
		if resource != null and (resource.type != ResourceType.Enum.HEALTH and resource.type != ResourceType.Enum.DASH_CHARGE):
			return resource.type as ResourceType.Enum
	return ResourceType.Enum.FREE
	
func reset_resources() -> void:
	for resource in resources:
		if resource != null:
			resource.reset()

func add_resource(resource: UnitResource) -> void:
	resources[resource.type] = resource
	unit_resource_added.emit(resource.type)
	
func remove_resource(resource: ResourceType.Enum) -> void:
	resources[resource] = null
	unit_resource_removed.emit(resource)

func get_resource(resource_type: ResourceType.Enum) -> UnitResource:
	return resources[resource_type]
	
func has_resource(resource_type: ResourceType.Enum) -> bool:
	return resources[resource_type] != null
	
func has_resource_amount(resource_type: ResourceType.Enum, amount: int) -> bool:
	return amount <= 0 or (has_resource(resource_type) and get_resource(resource_type).get_value() >= amount)
	
func increase_resource_value(resource_type: ResourceType.Enum, value: int) -> int:
	if has_resource(resource_type) and not is_dead():
		var change = get_resource(resource_type).increase_value(value)
		if resource_type == ResourceType.Enum.HEALTH  and get_resource(ResourceType.Enum.HEALTH).get_value() == 0 and not is_dead():
			alive = false
			died.emit(self)
			EventBus.emit_event(
				"UNIT_DIED",
				{
					unit = self
				}
			)
		return change
	return 0
	
func kill() -> void:
	increase_resource_value(ResourceType.Enum.HEALTH, -get_resource(ResourceType.Enum.HEALTH).get_value())
	
func is_dead() -> bool:
	return not alive

# Abilities
var abilities: Array[Ability] = []

# State

@onready
var state: StateMachine = $State

var alive: bool = true

# Status Effects
var status_effects: Array[Dictionary] = []
var status_effect_updates_enabled: bool = true

signal status_effect_applied(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit)
signal status_effect_refreshed(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit)
signal status_effect_dispelled(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit)
signal status_effect_removed(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit)
signal status_effect_stack_applied(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit)
signal status_effect_stack_removed(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit)

func update_status_effect(delta: float) -> void:
	if status_effect_updates_enabled:
		var i = 0
		while i < status_effects.size():
			var status_effect_application = status_effects[i]
			if is_instance_valid(status_effect_application.source):
				for effect in status_effect_application.status_effect.effects:
					effect.on_status_effect_update(
						status_effect_application.status_effect,
						status_effect_application.stacks,
						status_effect_application.source,
						self,
						delta)
				if status_effect_application.status_effect.has_duration:
					status_effect_application.time += delta
					if status_effect_application.status_effect.duration <= status_effect_application.time:
						status_effects.remove_at(i)
						i -= 1
						for effect in status_effect_application.status_effect.effects:
							effect.on_status_effect_expired(
								status_effect_application.status_effect,
								status_effect_application.stacks,
								status_effect_application.source,
								self)
							effect.on_status_effect_removed(
								status_effect_application.status_effect,
								status_effect_application.stacks,
								status_effect_application.source,
								self)
						status_effect_removed.emit(
							status_effect_application.status_effect,
							status_effect_application.stacks,
							status_effect_application.source,
							self
						)
			else:
				status_effects.remove_at(i)
				i -= 1
				for effect in status_effect_application.status_effect.effects:
					effect.on_status_effect_expired(
						status_effect_application.status_effect,
						status_effect_application.stacks,
						null,
						self)
					effect.on_status_effect_removed(
						status_effect_application.status_effect,
						status_effect_application.stacks,
						null,
						self)
				status_effect_removed.emit(
					status_effect_application.status_effect,
					status_effect_application.stacks,
					null,
					self
				)
			i += 1
						
func apply_status_effect(status_effect: StatusEffect, source: Unit, stacks: int = 1) -> void:
	if status_effect.stackable:
		if has_status_effect_from_source(status_effect, source):
			var application = get_status_effect_application_from_source(status_effect, source)
			if application.status_effect.max_stacks > application.stacks:
				application.stacks += 1
				for effect in status_effect.effects:
					effect.on_status_effect_stack_applied(status_effect, stacks, source, self)
				status_effect_stack_applied.emit(
					application.status_effect,
					application.stacks,
					application.source,
					self
				)
			refresh_status_effect_application(application)
		else:
			status_effects.append({
				"status_effect": status_effect.duplicate(true),
				"source": source,
				"time": 0.0,
				"stacks": stacks,
			})
			for effect in status_effect.effects:
				effect.on_status_effect_applied(status_effect, stacks, source, self)
			status_effect_applied.emit(status_effect, stacks, source, self)
	else:
		if status_effect.unique and has_status_effect_from_source(status_effect, source):
			refresh_status_effect_application(get_status_effect_application_from_source(status_effect, source))
		else:
			status_effects.append({
				"status_effect": status_effect.duplicate(true),
				"source": source,
				"time": 0.0,
				"stacks": stacks,
			})	
			for effect in status_effect.effects:
				effect.on_status_effect_applied(status_effect, stacks, source, self)
			status_effect_applied.emit(status_effect, stacks, source, self)

func get_status_effect_application_from_source(status_effect: StatusEffect, source: Unit) -> Dictionary:
	for status_effect_application in status_effects:
		if status_effect_application.status_effect.alias == status_effect.alias and status_effect_application.status_effect.type == status_effect.type and status_effect_application.source == source:
			return status_effect_application
	return {}
	
func has_status_effect(status_effect: StatusEffect) -> bool:
	for status_effect_application in status_effects:
		if status_effect_application.status_effect.alias == status_effect.alias and status_effect_application.status_effect.type == status_effect.type:
			return true
	return false
	
func get_status_effect_stacks(status_effect: StatusEffect) -> int:
	for status_effect_application in status_effects:
		if status_effect_application.status_effect.alias == status_effect.alias and status_effect_application.status_effect.type == status_effect.type:
			return status_effect_application.stacks
	return 0
	
func get_status_effect_application(status_effect: StatusEffect) -> Dictionary:
	for status_effect_application in status_effects:
		if status_effect_application.status_effect.alias == status_effect.alias and status_effect_application.status_effect.type == status_effect.type:
			return status_effect_application
	return {}
	
func has_status_effect_from_source(status_effect: StatusEffect, source: Unit) -> bool:
	for status_effect_application in status_effects:
		if status_effect_application.status_effect.alias == status_effect.alias and status_effect_application.status_effect.type == status_effect.type and status_effect_application.source == source:
			return true
	return false
	
func refresh_status_effect_application(status_effect_application: Dictionary) -> void:
	status_effect_application.time = 0.0
	for effect in status_effect_application.status_effect.effects:
		effect.on_status_effect_refreshed(
			status_effect_application.status_effect,
			status_effect_application.stacks,
			status_effect_application.source,
			self)
	status_effect_refreshed.emit(
		status_effect_application.status_effect,
		status_effect_application.stacks,
		status_effect_application.source,
		self)

func remove_status_effect(status_effect: StatusEffect, source: Unit) -> void:
	if has_status_effect_from_source(status_effect, source):
		var application = get_status_effect_application_from_source(status_effect, source)
		status_effects.erase(application)
		for effect in application.status_effect.effects:
			effect.on_status_effect_removed(
				application.status_effect,
				application.stacks,
				source,
				self)
		status_effect_removed.emit(
			application.status_effect,
			application.stacks,
			source,
			self)
			
func remove_status_effect_stack(status_effect: StatusEffect, stacks: int = 1) -> void:
	if has_status_effect(status_effect):
		var application = get_status_effect_application(status_effect)
		if application.stacks > stacks:
			application.stacks -= stacks
			for effect in application.status_effect.effects:
				effect.on_status_effect_stack_removed(
					application.status_effect,
					stacks,
					application.source,
					self
				)
			status_effect_stack_removed.emit(
				application.status_effect,
				application.stacks,
				application.source,
				self
			)
		else:
			remove_status_effect(status_effect, application.source)
	
# Direction
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var direction: int = Direction.DOWN

signal direction_changed(direction: int)


# Combat
var combat_logic: CombatLogic = CombatLogic.new()

signal took_damage(value: int)
signal died(unit: Unit)
signal combat_logic_result(result: CombatLogicResult)

#Cast
var casting: bool = false
var cast_time: float = 0.0
var current_cast: float = 0.0
var casting_ability: Ability
var cast_target: Unit
var casting_enabled: bool = true

signal cast_started(source: Unit, target: Unit, ability: Ability, duration: float)
signal cast_canceled(source: Unit, target: Unit, ability: Ability)
signal cast_interupted(source: Unit, target: Unit, ability: Ability)
signal cast_finished(source: Unit, target: Unit, ability: Ability)
signal current_cast_update(source: Unit, target: Unit, ability: Ability, current_cast: float, cast_time: float)

func start_casting(target: Unit, ability: Ability) -> bool:
	if not is_casting():
		casting = true
		current_cast = 0.0
		cast_time = combat_logic.get_cast_time(self, ability)
		casting_ability = ability
		cast_target = target
		cast_started.emit(self, cast_target, casting_ability, cast_time)
		ability.on_cast_started(self, target)
		return true
	return false
	
func stop_casting() -> void:
	if is_casting():
		casting = false
		cast_canceled.emit(self, cast_target, casting_ability)
		casting_ability.on_cast_stopped(self, cast_target)
		cast_time = 0.0
		current_cast = 0.0
		casting_ability = null
		cast_target = null
		
func interupt_casting() -> void:
	if is_casting() and casting_ability.is_interuptable():
		casting = false
		cast_interupted.emit(self, cast_target, casting_ability)
		casting_ability.on_cast_interupted(self, cast_target, null)
		cast_time = 0.0
		current_cast = 0.0
		casting_ability = null
		cast_target = null
		
func is_casting() -> bool:
	return casting
	
func is_cast_finished() -> bool:
	return current_cast >= cast_time and is_casting()
	
func get_cast_time() -> float:
	return cast_time
	
func get_current_cast_time() -> float:
	return current_cast
	
func update_cast(delta: float) -> void:
	if is_casting() and casting_enabled:
		if cast_target == null:
			stop_casting()
			return
		current_cast += delta
		current_cast_update.emit(self, cast_target, casting_ability, current_cast, cast_time)
		if is_cast_finished():
			combat_logic.use_ability(self, cast_target, casting_ability)
			cast_time = 0.0
			current_cast = 0.0
			casting = false
			cast_finished.emit(self, cast_target, casting_ability)
			casting_ability.on_cast_finished(self, cast_target)
			casting_ability = null
			cast_target = null
			
func use_ability(target: Unit, ability: Ability) -> bool:
	var result = combat_logic.use_ability(self, target, ability)
	if result.type == ResultType.Enum.START_CAST:
		return start_casting(target, ability)
	else:
		return result.type == ResultType.Enum.SUCCESS

func _ready() -> void:
	base_stats = BaseStats.new(unit_data.level)
	movement_strategy = UnitMovementStrategy.new(self)
	set_stats(base_stats)
	stat_calculator = StatCalculator.new(self)
	resources.resize(ResourceType.Enum.size())
	resources[ResourceType.Enum.HEALTH] = Health.new(self)
	if model_animation.has_animation("Down"):
		model_animation.play("Down")
	combat_logic.ability_result.connect(on_ability_result)
		
func on_ability_result(result: CombatLogicResult) -> void:
	if result.target == self:
		var damage_number = DamageNumberComponent.instantiate()
		add_child(damage_number)
		damage_number.show_number(result)
		if result.source != self:
			result.source.combat_logic_result.emit(result)
	if result.source == self:
		if result.target != self:
			result.target.combat_logic_result.emit(result)
	combat_logic_result.emit(result)

func _process(delta: float) -> void:
	movement_velocity = movement_strategy.get_movement_velocity()
	for movement_modifier in movement_modifiers:
		movement_velocity = movement_modifier.modify_movement_speed(self, movement_velocity)
	for resource in resources:
		if resource != null:
			resource.update(delta)
	update_cast(delta)
	update_status_effect(delta)
	update_direction()
	
func _physics_process(delta: float) -> void:
	velocity = (movement_velocity * get_movement_speed() + pushback_velocity) * (delta * 60)
	move_and_slide()
	
func on_hurt(source: Unit, ability: Ability) -> void:
	combat_logic.cast_ability(source, self, ability)
	
func get_center() -> Vector2:
	return model.global_position + model.offset
		
func set_level(_level: int) -> void:
	var base_stats_for_new_level = BaseStats.new(_level)
	var base_stats_for_previous_level = BaseStats.new(unit_data.level)
	if _level <= max_level:
		unit_data.level = _level
	else:
		if _level < 1:
			unit_data.level = 1
		else:
			unit_data.level = max_level
	var stat_increase = base_stats_for_new_level.subtract_stat_set(base_stats_for_previous_level)
	stats.increase_by_stat_set(stat_increase)
	base_stats = BaseStats.new(unit_data.level)
	level_changed.emit(unit_data.level)
	
func set_stats(_stat_set: StatSet) -> void:
	if stats:
		stats.stat_changed.disconnect(on_stat_changed)
	stats = _stat_set
	for stat_assignment in unit_data.stats:
		stats.increase_stat(stat_assignment.stat, stat_assignment.value)
	stats.stat_changed.connect(on_stat_changed)
	for stat in stats.get_stats():
		stat_changed.emit(stat, stats.get_stat(stat))
		
func on_stat_changed(stat: int, new_value: int) -> void:
	stat_changed.emit(stat, new_value)

func get_movement_speed() -> float:
	return stat_calculator.get_movement_speed() + get_base_movement_speed()
	
func update_direction() -> void:
	var original_direction = direction
	if (movement_velocity.y != 0):
		if (movement_velocity.y > 0):
			direction = Direction.DOWN
		else:
			direction = Direction.UP
	if (movement_velocity.x != 0):
		if (movement_velocity.x > 0):
			direction = Direction.RIGHT
		else:
			direction = Direction.LEFT
	if (original_direction != direction):
		direction_changed.emit(direction)
	
func set_animation(animation_name: String) -> bool:
	print("setting animation ", animation_name)
	if model_animation.has_animation(animation_name):
		model_animation.play(animation_name)
		return true
	return false
	
func pause_animation() -> void:
	model_animation.pause()
	
func start_animation() -> void:
	model_animation.play()
	
var pushback_tween
	
func apply_pushback(pushback_direction: Vector2, pushback_strength: float, pushback_duration: float) -> void:
	if unit_data.knockbackable and Time.get_unix_time_from_system() - last_pushback > pushback_cooldown:
		if pushback_tween != null:
			pushback_tween.kill()
		pushback_tween = create_tween()
		last_pushback = Time.get_unix_time_from_system()
		pushback_velocity = pushback_direction.normalized() * (pushback_strength * 700) * (100.0 / unit_data.mass)
		pushback_tween.tween_property(self, "pushback_velocity", Vector2(0, 0), pushback_duration).set_ease(Tween.EASE_IN)
		pushback_tween.play()
		
func walk_to_position(path: Array[Vector2]) -> void:
	movement_strategy = PathMovementStrategy.new(self, path)
	
func get_alias() -> String:
	return unit_data.alias
	
func get_level() -> int:
	return unit_data.level
	
func get_mass() -> float:
	return unit_data.mass
	
func get_stats() -> StatSet:
	return stats
	
func get_base_movement_speed() -> float:
	return unit_data.base_movement_speed
	
func get_abilities() -> Array[Ability]:
	return abilities
	
func teleport(_position: Vector2) -> void:
	global_position = _position
	
func start() -> void:
	if state != null:
		state.transition_to(state.previous_state.name)
	
func pause() -> void:
	if state != null:
		state.transition_to("Disabled")
	
func freeze() -> void:
	if state != null:
		state.transition_to("Timefrozen")

func unfreeze() -> void:
	if state != null:
		state.transition_to(state.current_state.get_unpause_state())
