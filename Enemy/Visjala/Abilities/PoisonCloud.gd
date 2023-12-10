extends Ability

var PoisonCloudZone = preload("res://Enemy/Visjala/Abilities/PoisonCloudZone.tscn")

var target_position: Vector2

var telegraph

func use(source: Unit, _target: Unit) -> void:
	var zone = PoisonCloudZone.instantiate()
	source.get_parent().add_child(zone)
	zone.hitbox.unit = source
	zone.global_position = target_position
	source.died.connect(source_died.bind(zone))
	
func source_died(source: Unit, zone) -> void:
	zone.queue_free()

func on_cast_started(source: Unit, target: Unit) -> void:
	var position = target.global_position
	target_position = Globals.get_first_collision(source.get_world_2d(), target.global_position, position, [source, target])
	telegraph = CombatUtil.show_circular_telegraph(10, target_position)
	
func on_cast_stopped(source: Unit, target: Unit) -> void:
	telegraph.queue_free()
	
func on_cast_interupted(source: Unit, target: Unit, interupter: Unit) -> void:
	telegraph.queue_free()
	
func on_cast_finished(source: Unit, target: Unit) -> void:
	telegraph.queue_free()
