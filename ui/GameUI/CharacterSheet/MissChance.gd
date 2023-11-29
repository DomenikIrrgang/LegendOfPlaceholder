extends HBoxContainer

@onready
var stat_value: Label = $StatValue

func _ready():
	Globals.get_player().stat_changed.connect(on_stat_changed)
	on_stat_changed(Stat.Enum.MISS, 0)

func on_stat_changed(stat: Stat.Enum, _value: int) -> void:
	if stat == Stat.Enum.MISS:
		stat_value.text = str(snapped(Globals.get_player().stat_calculator.get_miss_chance(), 0.01)) + "%"
