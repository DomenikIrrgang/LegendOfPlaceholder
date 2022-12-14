extends PlayerState

var duration: float = 0.3
var initial_speed_increase: float = 5

var tween: Tween

func enter(_data := {}) -> void:
	tween = create_tween()
	tween.finished.connect(self.dash_finished)
	var original_velocity = player.velocity
	player.velocity = player.velocity * initial_speed_increase
	tween.tween_property(player, "velocity", original_velocity, duration).set_ease(Tween.EASE_OUT)
	tween.play()
	player.get_node("Dust").emitting = true
	
func exit() -> void:
	player.get_node("Dust").emitting = false
	
func dash_finished() -> void:
	state_machine.transition_to("Run")
