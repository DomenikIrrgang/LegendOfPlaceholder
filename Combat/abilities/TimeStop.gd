extends Ability

var TimestopDebuff = load("res://Resources/StatusEffects/Timestop.tres")

func use(source: Unit, _target: Unit) -> void:
	super(source, _target)
	for enemy in Globals.get_scene_tree().get_nodes_in_group("enemy"):
		if not enemy.is_in_group("boss"):
			enemy.apply_status_effect(TimestopDebuff, source)
