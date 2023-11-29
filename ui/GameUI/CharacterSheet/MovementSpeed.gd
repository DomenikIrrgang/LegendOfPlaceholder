extends HBoxContainer

@onready
var stat_value: Label = $StatValue

func _ready():
	Globals.get_player().stat_changed.connect(on_stat_changed)
	on_stat_changed(Stat.Enum.MOVEMENT_SPEED, 0)

func on_stat_changed(stat: Stat.Enum, _value: int) -> void:
	if stat == Stat.Enum.MOVEMENT_SPEED or stat == Stat.Enum.HASTE:
		stat_value.text = str(Globals.get_player().get_movement_speed())
