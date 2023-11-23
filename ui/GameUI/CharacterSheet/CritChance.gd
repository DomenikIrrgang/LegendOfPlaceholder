extends HBoxContainer

@onready
var stat_value: Label = $StatValue

func _ready():
	Globals.get_player().stat_changed.connect(on_stat_changed)
	on_stat_changed(Stat.Enum.CRIT, 0)

func on_stat_changed(stat: Stat.Enum, value: int) -> void:
	if stat == Stat.Enum.INTELLECT or stat == Stat.Enum.CRIT:
		stat_value.text = str(snapped(Globals.get_player().stat_calculator.get_critical_chance(), 0.01)) + "%"
