extends Node2D

@export
var speed: float = 10.0

@export
var duration: float = 2.0

@export
var texture_direction: Vector2 = Vector2(0, 1)

var ability: Ability
var direction: Vector2 = Vector2(1, 1)

@onready
var hitbox: HitBox2D = $HitBox

var honing: bool = false
var target: Unit

func _process(delta):
	duration -= delta
	if duration < 0.0:
		queue_free()
	if honing:
		rotation = texture_direction.angle_to(global_position.direction_to(target.global_position))
	
func init_projectile(source: Unit, _ability: Ability, _direction: Vector2, _speed: float = speed) -> void:
	ability = _ability
	direction = _direction
	speed = _speed
	hitbox.ability = ability
	hitbox.unit = source
	rotation = texture_direction.angle_to(direction)
	honing = false
	
func init_honing_projectile(source: Unit, _ability: Ability, _target: Unit, _speed: float = speed) -> void:
	ability = _ability
	target = _target
	speed = _speed
	hitbox.ability = ability
	hitbox.unit = source
	rotation = texture_direction.angle_to(global_position.direction_to(target.model.global_position))
	honing = true

func _physics_process(delta: float) -> void:
	if honing:
		global_position += global_position.direction_to(target.global_position).normalized() * speed * delta
	else:
		transform.origin += direction * speed * delta
