class_name EnvironmentLighting
extends DirectionalLight2D

signal energy_changed(new_energy: float)

var tween: Tween

func _process(delta):
	if tween.is_running():
		on_energy_changed()

func change_energy(new_energy: float, speed: float) -> void:
	tween = create_tween()
	tween.tween_property(self, "energy", new_energy, speed)
	tween.step_finished.connect(on_energy_changed)
	tween.finished.connect(on_energy_changed)
	tween.play()
	
func on_energy_changed():
	print("energy changed", energy)
	energy_changed.emit(energy)
