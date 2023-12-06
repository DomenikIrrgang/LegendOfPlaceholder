extends Ability

var FireballProjectile = preload("res://Combat/abilities/FireballAnimation.tscn")
var MeteoriteCharge = preload("res://Resources/StatusEffects/MeteoriteCharge.tres")

var base_value = -1
var base_scaling_factor = 0.0
var porjectile

func execute(source: Unit, target: Unit) -> void:
	super(source, target)
	if porjectile != null:
		porjectile.queue_free()

func use(source: Unit, target: Unit) -> void:
	super(source, target)
	porjectile = FireballProjectile.instantiate()
	if base_value == -1:
		base_value = value
		base_scaling_factor = scaling_factor
	Globals.get_world().add_child(porjectile)
	var target_position: Vector2
	if source == target:
		target_position = Globals.get_player().get_facing_direction()
	else:
		target_position = target.model.global_position - source.model.global_position
	var stacks = source.get_status_effect_stacks(MeteoriteCharge)
	value = base_value * stacks
	scaling_factor = base_scaling_factor * stacks
	source.remove_status_effect(MeteoriteCharge, source)
	porjectile.init_projectile(source, self, (target_position).normalized(), 100.0)
	porjectile.global_position = source.model.global_position
