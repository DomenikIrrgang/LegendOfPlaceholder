extends PlayerState

var duration: float = 0.3
var initial_speed_increase: float = 5

var tween: Tween

func enter(_data := {}) -> void:
	SceneSwitcher.zone_loaded.connect(on_zone_switch)
	tween = create_tween()
	tween.finished.connect(self.dash_finished)
	var original_velocity = player.movement_velocity
	var new_velocity = player.movement_velocity * initial_speed_increase
	player.movement_velocity = new_velocity
	tween.tween_property(player, "movement_velocity", original_velocity, duration).set_ease(Tween.EASE_OUT)
	tween.play()
	player.get_node("Dust").emitting = true
	player.movement_strategy = KeepVelocityMovementStrategy.new(player)
	
func on_zone_switch(zone: Zone) -> void:
	tween.finished.disconnect(dash_finished)
	SceneSwitcher.zone_loaded.disconnect(on_zone_switch)
	tween.kill()
	dash_finished()
	
func exit() -> void:
	player.movement_velocity = Vector2(0, 0)
	player.get_node("Dust").emitting = false
	
func dash_finished() -> void:
	state_machine.transition_to("Run")
