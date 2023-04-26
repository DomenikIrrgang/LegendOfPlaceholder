class_name DashMeter
extends Control

@onready
var progress_bar: TextureProgressBar = $ProgressBar

@onready
var charges_label: Label = $Charges

var player: Player

func initialize(_player: Player):
	player = _player
	player.dash.resource_value_changed.connect(update_progress_bar)
	progress_bar.max_value = player.dash.scaling_factor
	progress_bar.value = fmod(player.dash.get_value(), player.dash.scaling_factor)
	
func update_progress_bar(_new_value: float, _change: int) -> void:
	progress_bar.value = fmod(player.dash.get_value(), player.dash.scaling_factor)
	charges_label.text = str(player.dash.get_charges())
	
	
