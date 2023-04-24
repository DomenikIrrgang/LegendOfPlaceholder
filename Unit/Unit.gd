class_name Unit
extends CharacterBody2D

@export
var alias: String

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

@onready
var hurt_box: HurtBox2D = $HurtBox2D

# Base Stats
var level: int = 1
var max_level: int = 60
var base_movement_speed: float = 30.0
var mass: float = 50.0

var stat_calculator: StatCalculator
var base_stats: StatSet
var stats: StatSet

signal stat_changed(stat: Stat, new_value: int)
signal level_changed(level: int)

# Movement
var pushback_velocity: Vector2 = Vector2(0, 0)
var movement_velocity: Vector2 = Vector2(0, 0)
var movement_strategy: UnitMovementStrategy = UnitMovementStrategy.new(self)

# Health
var health: Health

# Direction
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var direction: int = Direction.DOWN

signal direction_changed(direction: int)

func _ready() -> void:
	base_stats = BaseStats.new(level)
	set_stats(base_stats)
	stat_calculator = StatCalculator.new(self)
	health = Health.new(stat_calculator)
	#movement_strategy = FollowMovementStrategy.new(self, get_node("../Player"))
	movement_strategy = UnitMovementStrategy.new(self)
	model_animation.play("Down")
	hurt_box.got_hurt.connect(on_hurt)
	

func _process(_delta: float) -> void:
	movement_velocity = movement_strategy.calculateMovementVelocity()
	update_direction()
	
func _physics_process(delta: float) -> void:
	velocity = (movement_velocity * get_movement_speed() + pushback_velocity) * (delta * 60)
	move_and_slide()
	
func on_hurt(source: Unit, ability: Ability) -> void:
	ability.execute(source, self)
	
func set_level(_level: int) -> void:
	if _level <= max_level:
		level = _level
	else:
		if _level < 1:
			level = 1
		else:
			level = max_level
	set_stats(stats.subtract_stat_set(base_stats).add_stat_set(BaseStats.new(level)))
	base_stats = BaseStats.new(level)
	level_changed.emit(level)
	
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
	return stats.get_stat(Stat.MOVEMENT_SPEED) + base_movement_speed
	
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
	var tween = create_tween()
	pushback_velocity = pushback_direction.normalized() * (pushback_strength * 700) * (100.0 / mass)
	tween.tween_property(self, "pushback_velocity", Vector2(0, 0), pushback_duration).set_ease(Tween.EASE_IN)
	tween.play()
	
func change_health(change: int) -> int:
	return health.increase_value(change)
