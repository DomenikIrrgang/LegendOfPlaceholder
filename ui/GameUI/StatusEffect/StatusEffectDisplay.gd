class_name StatusEffectDisplay
extends VBoxContainer

@export
var status_effect_application: Dictionary

@onready
var duration: Label = $Duration

@onready
var icon: TextureRect = $Display/CenterContainer/Icon

@onready
var stacks: Label = $Display/Stacks

func set_status_effect_application(_status_effect_application: Dictionary, duration_position: StatusEffectDurationPosition.Enum) -> void:
	status_effect_application = _status_effect_application
	icon.texture = status_effect_application.status_effect.icon
	stacks.visible = status_effect_application.status_effect.stackable
	stacks.text = str(status_effect_application.stacks)
	if duration_position == StatusEffectDurationPosition.Enum.TOP:
		move_child(duration, 0)
	else:
		move_child(duration, 2)
	
func _process(_delta: float) -> void:
	if status_effect_application.status_effect.has_duration:
		var _duration = get_remaining_duration()
		if _duration < 60:
			if _duration < 1:
				duration.text = str(snapped(_duration, 0.1)) + "s"
			else:
				duration.text = str(floor(_duration)) + "s"
		else:
			duration.text = str(snapped(_duration / 60, 0)) + "m"
	else:
		duration.text = ""

func get_remaining_duration() -> float:
	return status_effect_application.status_effect.duration - status_effect_application.time
