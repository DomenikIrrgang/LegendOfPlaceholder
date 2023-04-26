extends HitBox2D

func _ready() -> void:
	super()
	unit = owner.get_parent()

func on_hit(hurt_box: HurtBox2D) -> void:
	var target = hurt_box.owner
	var pushback_strength = 0.1
	var hit_direction = global_position.direction_to(target.global_position)
	target.apply_pushback(hit_direction, pushback_strength, 0.3)
