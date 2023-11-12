class_name EnvironmentLighting
extends DirectionalLight2D

signal energy_changed(new_energy: float)

func change_energy(new_energy: float, speed: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "energy", new_energy, speed)
	tween.step_finished.connect(on_energy_changed)
	tween.finished.connect(on_energy_changed)
	tween.play()
	
func on_energy_changed():
	print("energy changed", energy)
	energy_changed.emit(energy)
