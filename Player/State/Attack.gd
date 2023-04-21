extends PlayerState

var attack_animation: AnimationPlayer

func on_animation_finshed(_animation_name: String) -> void:
	state_machine.transition_to("Idle")
	attack_animation.disconnect("animation_finished", on_animation_finshed)

func enter(_data := {}) -> void:
	player.movement_velocity = Vector2.ZERO
	attack_animation = player.attack()
	attack_animation.connect("animation_finished", on_animation_finshed)

func exit() -> void:
	pass
