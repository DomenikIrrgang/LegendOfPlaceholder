extends Ability

var FireballProjectile = preload("res://Combat/abilities/FireballAnimation.tscn")

func execute(source: Unit, target: Unit) -> void:
	var pushback_strength = 0.1
	var hit_direction = source.global_position.direction_to(target.global_position)
	target.apply_pushback(hit_direction, pushback_strength, 0.3)


func use(source: Unit, target: Unit) -> void:
	var fireball_projectile_instance = FireballProjectile.instantiate()
	Globals.get_world().add_child(fireball_projectile_instance)
	fireball_projectile_instance.init_projectile(source, self, (target.model.global_position - source.model.global_position).normalized(), 100.0)
	fireball_projectile_instance.global_position = source.model.global_position
