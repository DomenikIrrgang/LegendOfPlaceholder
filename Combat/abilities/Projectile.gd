extends Node2D

@export
var speed: float = 10.0

@export
var duration: float = 2.0

var ability: Ability
var direction: Vector2 = Vector2(1, 1)

@onready
var hitbox: HitBox2D = $HitBox

func _process(delta):
	duration -= delta
	if duration < 0.0:
		queue_free()
	
func init_projectile(source: Unit, _ability: Ability, _direction: Vector2, _speed: float = speed) -> void:
	ability = _ability
	direction = _direction
	speed = _speed
	hitbox.ability = ability
	hitbox.unit = source

func _physics_process(delta: float) -> void:
	transform.origin += direction * speed * delta
