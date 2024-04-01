extends PlayerState

var attack_animation: AnimationPlayer

func update(_delta: float) -> void:
	if attack_animation != null and not attack_animation.is_playing():
		state_machine.transition_to("Idle")

func on_animation_finshed(_animation_name: String) -> void:
	state_machine.transition_to("Idle")

func enter(_data := {}) -> void:
	player.movement_strategy = UnitMovementStrategy.new(player)
	attack_animation = player.weapon.attack(player)
	attack_animation.connect("animation_finished", on_animation_finshed)

func exit() -> void:
	attack_animation.disconnect("animation_finished", on_animation_finshed)
