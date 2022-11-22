extends PlayerState

var duration: float = 0.3
var initial_speed_increase: float = 5

var tween: Tween

func enter(_data := {}) -> void:
	tween = create_tween()
	tween.finished.connect(self.dash_finished)
	var original_velocity = player.velocity
	player.velocity = player.velocity * initial_speed_increase
	print(original_velocity, player.velocity)
	tween.tween_property(player, "velocity", original_velocity, duration).set_ease(Tween.EASE_OUT)
	tween.play()

func update(_delta: float) -> void:
	print(player.velocity)
	
func dash_finished() -> void:
	print("dash finished")
	state_machine.transition_to("Run")
