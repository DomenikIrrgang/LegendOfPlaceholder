class_name ZoneOfDoom
extends Ability

var ZoneOfDoomVoid = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoomVoid.tscn")

func use(source: Unit, target: Unit) -> void:
	var zone = ZoneOfDoomVoid.instantiate()
	source.get_parent().add_child(zone)
	zone.hitbox.unit = source
	zone.hitbox.ability = self
	zone.global_position = Globals.get_player().global_position + Vector2(randi_range(-15, 15), randi_range(-15, 15))
