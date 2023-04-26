class_name ZoneOfDoom
extends Ability

@export
var source: Enemy

@onready
var hitbox: HitBox2D = $HitBox

func _ready() -> void:
	hitbox.unit = source
	hitbox.ability = self
