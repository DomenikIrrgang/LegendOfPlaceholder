extends HBoxContainer

@onready
var stat_name: Label = $StatName

@onready
var stat_value: Label = $StatValue

@export
var stat: Stat.Enum

func _ready() -> void:
	Globals.get_player().stat_changed.connect(on_stat_changed)
	stat_name.text = Stat.Enum.keys()[stat].capitalize()
	on_stat_changed(stat, 0)
	
func update_stat_value(value: int) -> void:
	stat_value.text = str(value)

func on_stat_changed(_stat: Stat.Enum, _value: int) -> void:
	if stat == Stat.Enum.ATTACK_POWER:
		if _stat == Stat.Enum.ATTACK_POWER or _stat == Stat.Enum.AGILITY:
			update_stat_value(Globals.get_player().stat_calculator.get_attack_power())
	else:
		if stat == Stat.Enum.SPELL_POWER:
			update_stat_value(Globals.get_player().stat_calculator.get_spell_power(SpellSchool.Enum.FIRE) - Globals.get_player().stats.get_stat(SpellSchool.SPELLPOWER[SpellSchool.Enum.FIRE]))
		else:
			if _stat == Stat.Enum.SPELL_POWER or stat == _stat or _stat == Stat.Enum.INTELLECT:
				update_stat_value(Globals.get_player().stat_calculator.get_spell_power(SpellSchool.get_spell_power_for_stat(stat)))
