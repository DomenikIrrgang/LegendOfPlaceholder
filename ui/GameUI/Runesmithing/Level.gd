extends Label

func _ready() -> void:
	RunesmithingManager.leveled_up.connect(on_level_up)
	text = get_level_text(RunesmithingManager.level)
	
func on_level_up(level: int) -> void:
	text = get_level_text(level)
	
func get_level_text(level: int) -> String:
	return "Level " + str(level)
