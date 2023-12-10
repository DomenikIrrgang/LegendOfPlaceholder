extends Ability

var PoisonBoltProjectile = preload("res://Enemy/Visjala/Abilities/PoisonBoltProjectile.tscn")
var fireball_debuff = preload("res://Resources/StatusEffects/Fireball/FireballDebuff.tres")
var poison_bolt = preload("res://Enemy/Visjala/Abilities/PoisonBolt.tscn").instantiate()

func execute(source: Unit, target: Unit) -> void:
	target.apply_status_effect(fireball_debuff, source)

func use(source: Unit, target: Unit) -> void:
	shoot_poison_bolt(source, Vector2(-1, 0))
	shoot_poison_bolt(source, Vector2(-1, 1))
	shoot_poison_bolt(source, Vector2(1, 1))
	shoot_poison_bolt(source, Vector2(0, 1))
	shoot_poison_bolt(source, Vector2(1, 0))

func shoot_poison_bolt(source: Unit, direction: Vector2) -> void:
	var poison_projectile_instance = PoisonBoltProjectile.instantiate()
	Globals.get_world().add_child(poison_projectile_instance)
	poison_projectile_instance.init_projectile(source, poison_bolt, (direction).normalized(), 350.0)
	poison_projectile_instance.global_position = source.model.global_position
