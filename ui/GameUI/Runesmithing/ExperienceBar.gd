extends TextureProgressBar

var level: int = 1
var speed = 1.5

func _ready() -> void:
	RunesmithingManager.experience_gained.connect(on_experience_gained)
	RunesmithingManager.experience_set.connect(func(amount: int):
		level = RunesmithingManager.level
		max_value = RunesmithingManager.get_experience_needed_for_level(level)
		value = RunesmithingManager.experience
	)
	level = RunesmithingManager.level
	max_value = RunesmithingManager.get_experience_needed_for_level(level)
	value = RunesmithingManager.experience
	
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
	var old_value = value
	var preview_value = amount
	var old_experience =  RunesmithingManager.experience
	var total_xp = RunesmithingManager.get_experience_needed_for_level(RunesmithingManager.level)
	update_experience_amount()
