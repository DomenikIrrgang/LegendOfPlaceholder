extends Ability

var PoisonBoltProjectile = preload("res://Enemy/Visjala/Abilities/PoisonBoltProjectile.tscn")
var visjalas_venom = preload("res://Enemy/Visjala/StatusEffects/VisjalasVenom.tres")

func execute(source: Unit, target: Unit) -> void:
	target.apply_status_effect(visjalas_venom, source)

func use(source: Unit, target: Unit) -> void:
	var poison_projectile_instance = PoisonBoltProjectile.instantiate()
	Globals.get_world().add_child(poison_projectile_instance)
	var target_position: Vector2
	if source == target:
		target_position = Globals.get_player().get_facing_direction()
	else:
		target_position = target.get_center() - source.get_center()
	poison_projectile_instance.init_projectile(source, self, (target_position).normalized(), 350.0)
	poison_projectile_instance.global_position = source.get_center()
