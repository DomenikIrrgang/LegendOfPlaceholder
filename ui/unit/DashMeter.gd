class_name DashMeter
extends Control

@onready
var progress_bar: TextureProgressBar = $ProgressBar

@onready
var charges_label: Label = $Charges

var player: Player

func initialize(_player: Player):
	player = _player
	player.dash_charges_changed.connect(update_progress_bar)
	progress_bar.max_value = 1000
	progress_bar.value = fmod(player.dash_charges, 1.0) * 1000
	
func update_progress_bar(new_value: float, _change: int) -> void:
	progress_bar.value = fmod(new_value, 1.0) * 1000
	charges_label.text = str(floor(new_value))
	
	
