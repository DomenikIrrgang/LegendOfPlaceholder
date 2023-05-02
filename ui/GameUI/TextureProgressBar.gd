class_name DashBar
extends TextureProgressBar

var player: Player
var dash_resource: DashCharge

func initialize(_player: Player):
	player = _player
	dash_resource = player.get_resource(ResourceType.Enum.DASH_CHARGE)
	dash_resource.resource_value_changed.connect(update_progress_bar)
	max_value = dash_resource.scaling_factor
	update_progress_bar(dash_resource, dash_resource.get_value(), 0, 0)
	
func update_progress_bar(_resource: UnitResource, _new_value: float, _change: int, _original_change: int) -> void:
	if (dash_resource.get_value() != dash_resource.get_maximum_value()):
		value = fmod(dash_resource.get_value(), dash_resource.scaling_factor)
	else:
		value = max_value
	
