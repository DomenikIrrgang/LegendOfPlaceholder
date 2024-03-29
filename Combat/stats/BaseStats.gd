class_name BaseStats
extends StatSet

func _init(level: int) -> void:
	set_stat(Stat.Enum.HEALTH, 8 * level)
	set_stat(Stat.Enum.AGILITY, level)
	set_stat(Stat.Enum.INTELLECT, level)
	set_stat(Stat.Enum.STAMINA, level)
	set_stat(Stat.Enum.DEFENSE, level)
	set_stat(Stat.Enum.MASTERY, level)
