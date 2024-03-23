extends Model

@onready
var save_crystal: Sprite2D = $Model/Crystal

func get_model_height() -> int:
	return save_crystal.get_rect().size.y

func get_idle_down_animation() -> String:
	return "Idle"
	
func get_idle_up_animation() -> String:
	return "Idle"
	
func get_idle_left_animation() -> String:
	return "Idle"
	
func get_idle_right_animation() -> String:
	return "Idle"
	
func get_down_animation() -> String:
	return "Idle"
	
func get_up_animation() -> String:
	return "Idle"
	
func get_left_animation() -> String:
	return "Idle"
	
func get_right_animation() -> String:
	return "Idle"
