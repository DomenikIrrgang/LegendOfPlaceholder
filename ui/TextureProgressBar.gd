class_name DashBar
extends TextureProgressBar

var player: Player

func initialize(_player: Player):
	player = _player
	player.dash.resource_value_changed.connect(update_progress_bar)
	max_value = player.dash.scaling_factor
	value = fmod(player.dash.get_value(), player.dash.scaling_factor)
	
func update_progress_bar(_new_value: float, _change: int) -> void:
	value = fmod(player.dash.get_value(), player.dash.scaling_factor)	
	
