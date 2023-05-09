extends Node2D

@export
var speed: float = 10.0

var ability: Ability
var direction: Vector2 = Vector2(1, 1)

@onready
var hitbox: HitBox2D = $HitBox

func init_projectile(_ability: Ability, _direction: Vector2, _speed: float = speed) -> void:
	ability = _ability
	direction = _direction
	speed = _speed
	hitbox.ability = ability
	hitbox.unit = Globals.get_player()

func _physics_process(delta: float) -> void:
	transform.origin += direction * speed * delta
