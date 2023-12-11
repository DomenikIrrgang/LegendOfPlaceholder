extends Ability

var PoisonBoltProjectile = preload("res://Enemy/Visjala/Abilities/PoisonBoltProjectile.tscn")
var visjalas_venom = preload("res://Enemy/Visjala/StatusEffects/VisjalasVenom.tres")

var projectile

func execute(source: Unit, target: Unit) -> void:
	target.apply_status_effect(visjalas_venom, source)
	if projectile != null:
		projectile.queue_free()

func use(source: Unit, target: Unit) -> void:
	if source == Globals.get_player():
		target = Globals.get_closest_enemy()
	if target != null:
		var poison_projectile_instance = PoisonBoltProjectile.instantiate()
		Globals.get_world().add_child(poison_projectile_instance)
		poison_projectile_instance.init_honing_projectile(source, self, target, 80.0)
		poison_projectile_instance.global_position = source.model.global_position
