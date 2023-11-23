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
	if stat == _stat or _stat == Stat.Enum.STAMINA:
		update_stat_value(Globals.get_player().stat_calculator.get_resistance(SpellSchool.get_spell_resistance_for_stat(stat)))
