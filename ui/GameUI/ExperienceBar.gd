class_name ExperienceBar
extends TextureProgressBar

var player: Player
var animation_speed: float = 0.2
var tween: Tween

var text: String = ""

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
		if tween:
			tween.stop()
		tween = create_tween()
		tween.tween_property(self, "value", player.current_experience(), animation_speed)
		tween.play()
		max_value = player.experience_needed_for_next_level()
		text = str(player.current_experience()) + "/" + str(max_value)
	else:
		visible = false
