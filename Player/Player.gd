class_name Player
extends CharacterBody2D

@export
var speed: float = 50

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

func attack() -> AnimationPlayer:
	return $WeaponAnimation
	
func get_directional_vector() -> Vector2:
	return Vector2(0, 0)
	
func get_direction() -> int:
	if (velocity.x != 0):
		if (velocity.x > 0):
			return Direction.RIGHT
		else:
			return Direction.LEFT
	if (velocity.y < 0):
		return Direction.UP
	return Direction.DOWN
