class_name ZoneOfDoom
extends Ability

var ZoneOfDoomVoid = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoomVoid.tscn")

func use(source: Unit, target: Unit) -> void:
	var zone = ZoneOfDoomVoid.instantiate()
	source.get_parent().add_child(zone)
	zone.hitbox.unit = source
	zone.hitbox.ability = self
	var position = target.global_position
	zone.global_position = Globals.get_first_collision(source.get_world_2d(), target.global_position, position, [source, target])
