class_name ExperienceBar
extends CenterContainer

@onready
var experience_bar: TextureProgressBar = $Bar

@onready
var current_experience_label: Label = $Bar/CurrentExperience

@onready
var experience_needed_label: Label = $Bar/ExperienceNeeded

var player: Player
var animation_speed: float = 0.2
var tween: Tween

func initialize(_player: Player) -> void:
	player = _player
	player.experience_changed.connect(experience_changed)
	player.level_changed.connect(level_changed)
	update_bar()
	
func experience_changed(_amount: int) -> void:
	update_bar()
	
func level_changed(_level: int) -> void:
	update_bar()	
	
func update_bar() -> void:
	if player.get_level() < player.max_level:
		current_experience_label.text = str(player.current_experience())
		experience_needed_label.text = "/" + str(player.experience_needed_for_next_level())
		if tween:
			tween.stop()
		tween = create_tween()
		tween.tween_property(experience_bar, "value", player.current_experience(), animation_speed)
		tween.play()
		experience_bar.max_value = player.experience_needed_for_next_level()
	else:
		visible = false
