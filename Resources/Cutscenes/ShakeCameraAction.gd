class_name ShakeCameraAction
extends CutsceneAction

@export
var strength: float = 60.0

@export
var duration: float = 1.0

var camera_shake: CameraShake
var time_passed: float

func start() -> void:
	camera_shake = CameraShake.new()
	camera_shake.init_shake(strength, duration)
	time_passed = 0.0

func update(delta: float) -> void:
	time_passed += delta
	camera_shake.shake(time_passed, delta)
	if time_passed >= duration:
		camera_shake.stop_shake()
		cutscene_action_finished.emit(self)
