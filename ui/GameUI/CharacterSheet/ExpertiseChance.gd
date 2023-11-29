extends HBoxContainer

@onready
var stat_value: Label = $StatValue

func _ready():
	Globals.get_player().stat_changed.connect(on_stat_changed)
	on_stat_changed(Stat.Enum.EXPERTISE, 0)

func on_stat_changed(stat: Stat.Enum, _value: int) -> void:
	if stat == Stat.Enum.EXPERTISE:
		stat_value.text = str(snapped(Globals.get_player().stat_calculator.get_expertise(), 0.01)) + "%"
