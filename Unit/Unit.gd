class_name Unit
extends CharacterBody2D

var DamageNumber = preload("res://Ui/unit/DamageNumber.tscn")

@export
var unit_data: UnitData

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

@onready
var hurt_box: HurtBox2D = $HurtBox2D

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
var movement_strategy: UnitMovementStrategy = UnitMovementStrategy.new(self)

# Resources
var resources: Array[UnitResource] = []

# Abilities
var abilities: Array[Ability] = []

# Direction
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var direction: int = Direction.DOWN

signal direction_changed(direction: int)

signal took_damage(value: int)
signal died(unit: Unit)

func _ready() -> void:
	base_stats = BaseStats.new(unit_data.level)
	for stat_assignment in unit_data.stats:
		base_stats.increase_stat(stat_assignment.stat, stat_assignment.value)
	set_stats(base_stats)
	stat_calculator = StatCalculator.new(self)
	resources.resize(ResourceType.Enum.size())
	resources[ResourceType.Enum.HEALTH] = Health.new(stat_calculator)
	movement_strategy = UnitMovementStrategy.new(self)
	model_animation.play("Down")
	hurt_box.got_hurt.connect(on_hurt)
	CombatLogic.ability_result.connect(on_ability_result)
	
func on_ability_result(result: AbilityCastResultEntry) -> void:
	if result.target == self:
		var damage_number = DamageNumber.instantiate()
		add_child(damage_number)
		damage_number.show_number(result)
	
func is_dead() -> bool:
	return get_resource(ResourceType.Enum.HEALTH).get_value() == 0
	
func get_resource(resource_type: ResourceType.Enum) -> UnitResource:
	return resources[resource_type]
	
func has_resource(resource_type: ResourceType.Enum) -> bool:
	return resources[resource_type] != null
	
func has_resource_amount(resource_type: ResourceType.Enum, amount: int) -> bool:
	return amount <= 0 or (has_resource(resource_type) and get_resource(resource_type).get_value() >= amount)
	
func increase_resource_value(resource_type: ResourceType.Enum, value: int) -> int:
	if has_resource(resource_type):
		var change = get_resource(resource_type).increase_value(value)
		if is_dead():
			died.emit(self)
		return change
	return 0

func _process(_delta: float) -> void:
	movement_velocity = movement_strategy.get_movement_velocity()
	update_direction()
	
func _physics_process(delta: float) -> void:
	velocity = (movement_velocity * get_movement_speed() + pushback_velocity) * (delta * 60)
	move_and_slide()
	
func on_hurt(source: Unit, ability: Ability) -> void:
	CombatLogic.cast_ability(ability, source, self)
		
func set_level(_level: int) -> void:
	if _level <= max_level:
		unit_data.level = _level
	else:
		if _level < 1:
			unit_data.level = 1
		else:
			unit_data.level = max_level
	set_stats(stats.subtract_stat_set(base_stats).add_stat_set(BaseStats.new(unit_data.level)))
	base_stats = BaseStats.new(unit_data.level)
	level_changed.emit(unit_data.level)
	
func set_stats(_stat_set: StatSet) -> void:
	if stats:
		stats.stat_changed.disconnect(on_stat_changed)
	stats = _stat_set
	stats.stat_changed.connect(on_stat_changed)
	for stat in stats.get_stats():
		stat_changed.emit(stat, stats.get_stat(stat))
		
func on_stat_changed(stat: int, new_value: int) -> void:
	stat_changed.emit(stat, new_value)

func get_movement_speed() -> float:
	return stats.get_stat(Stat.Enum.MOVEMENT_SPEED) + get_base_movement_speed()
	
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
	
func set_animation(animation_name: String) -> void:
	model_animation.play(animation_name)
	
func apply_pushback(pushback_direction: Vector2, pushback_strength: float, pushback_duration: float) -> void:
	if unit_data.knockbackable and Time.get_unix_time_from_system() - last_pushback > pushback_cooldown:
		var tween = create_tween()
		last_pushback = Time.get_unix_time_from_system()
		pushback_velocity = pushback_direction.normalized() * (pushback_strength * 700) * (100.0 / unit_data.mass)
		tween.tween_property(self, "pushback_velocity", Vector2(0, 0), pushback_duration).set_ease(Tween.EASE_IN)
		tween.play()
	
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
