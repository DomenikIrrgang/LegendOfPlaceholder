extends TextureProgressBar

var level: int = 1
var speed = 1.5

func _ready() -> void:
	RunesmithingManager.experience_gained.connect(on_experience_gained)
	level = RunesmithingManager.level
	value = RunesmithingManager.experience
	max_value = RunesmithingManager.get_experience_needed_for_level(level)
	
func update_experience_amount() -> void:
	if level == RunesmithingManager.level:
		var tween = create_tween()
		tween.finished.connect(func(): 
			tween.kill()
		)
		tween.tween_property(self, "value", RunesmithingManager.experience, get_normalized_speed(RunesmithingManager.experience))
		tween.play()
	else:
		var tween = create_tween()
		tween.finished.connect(func(): 
			tween.kill()
			if RunesmithingManager.level != level:
				level += 1
			value = 0
			max_value = RunesmithingManager.get_experience_needed_for_level(level)
			update_experience_amount()
		)
		tween.tween_property(self, "value", max_value, get_normalized_speed(max_value))
		tween.play()
		
func get_normalized_speed(target_value: float) -> float:
	return speed * ((target_value - value) / max_value)
	
func on_experience_gained(amount: int) -> void:
	update_experience_amount()
