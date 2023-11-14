class_name EnvironmentLighting
extends DirectionalLight2D

signal energy_changed(new_energy: float)

var environment_energy: float : set = _set_environment_energy, get = _get_environment_energy

var tween: Tween

func change_energy(new_energy: float, speed: float) -> void:
	if tween != null:
		tween.stop()
	tween = create_tween()
	tween.tween_property(self, "environment_energy", new_energy, speed)
	tween.play()
	
func _set_environment_energy(new_value: float) -> void:
	environment_energy = new_value
	energy = environment_energy
	energy_changed.emit(environment_energy)

func _get_environment_energy() -> float:
	return environment_energy
