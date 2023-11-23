extends HBoxContainer

@export
var stat: Stat.Enum

@export
var displayed_stat_name: String

@onready
var stat_name: Label = $StatName

@onready
var stat_value: Label = $StatValue

func _ready():
	set_stat_name()
	set_stat_value()
	Globals.get_player().stat_changed.connect(on_stat_changed)
	
func set_stat_name() -> void:
	if displayed_stat_name == "" or displayed_stat_name == null:
		stat_name.text = Stat.Enum.keys()[stat].capitalize()
		
func set_stat_value() -> void:
	stat_value.text = str(Globals.get_player().stats.get_stat(stat))

func on_stat_changed(_stat: Stat.Enum, value: int) -> void:
	if stat == _stat:
		stat_value.text = str(value)
