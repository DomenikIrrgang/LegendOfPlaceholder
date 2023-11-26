class_name ZoneOfDoom
extends Ability

var ZoneOfDoomVoid = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoomVoid.tscn")

var target_position: Vector2

func use(source: Unit, _target: Unit) -> void:
	var zone = ZoneOfDoomVoid.instantiate()
	source.get_parent().add_child(zone)
	zone.hitbox.unit = source
	zone.hitbox.ability = self
	zone.global_position = target_position

func on_cast_started(source: Unit, target: Unit) -> void:
	var position = target.global_position
	target_position = Globals.get_first_collision(source.get_world_2d(), target.global_position, position, [source, target])
