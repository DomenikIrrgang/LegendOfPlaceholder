class_name ChangeEnvironmentLightAction
extends CutsceneAction

@export
var target_energy: float = 0.0

@export
var speed: float = 1.0

func start() -> void:
	Globals.get_environment_light().connect("energy_changed", on_energy_changed)
	Globals.get_environment_light().change_energy(target_energy, speed)
	
func on_energy_changed(energy) -> void:
	if energy == target_energy:
		Globals.get_environment_light().disconnect("energy_changed", on_energy_changed)
		cutscene_action_finished.emit(self)
