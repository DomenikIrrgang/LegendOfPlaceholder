class_name BaseStats
extends StatSet

func _init(level: int) -> void:
	set_stat(Stat.HEALTH, 20 * level)
	set_stat(Stat.AGILITY, level)
	set_stat(Stat.INTELLECT, level)
	set_stat(Stat.STAMINA, level)
	set_stat(Stat.DEFENSE, level)
