extends TextureProgressBar

func _ready() -> void:
	RunesmithingManager.experience_gained.connect(on_experience_gained)
	update_experience_amount()
	
func update_experience_amount() -> void:
	value = RunesmithingManager.experience
	max_value = RunesmithingManager.get_experience_needed_for_level(RunesmithingManager.level)
	
func on_experience_gained(amount: int) -> void:
	update_experience_amount()
