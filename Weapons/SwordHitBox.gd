extends HitBox2D

func _ready() -> void:
	super()
	unit = owner.get_parent()

func on_hit(hurt_box: HurtBox2D) -> void:
	var unit = hurt_box.owner
	var pushback_strength = 0.2
	var hit_direction = global_position.direction_to(unit.global_position)
	unit.apply_pushback(hit_direction, pushback_strength, 0.3)
