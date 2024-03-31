class_name CameraShake
extends Node

var shake_strength_max: float = 60.0
var shake_strength_decay: float = 5.0
var shake_speed: float = 30.0

var shake_strength: float = 60.0
var duration: float = 1.0
var noise_i: float = 0.0

var random = RandomNumberGenerator.new()
var noise = FastNoiseLite.new()

func init_shake(strength: float = shake_strength_max, _duration: float = duration) -> void:
	shake_strength_max = strength
	shake_strength = strength
	duration = _duration
	noise.seed = random.randi()
	noise.frequency = 1.0

func shake(time_passed: float, delta: float) -> void:
	var multiplier = (1 - (time_passed / duration))
	shake_strength = shake_strength_max * multiplier
	Globals.get_camera().offset = get_random_offset(delta)
	
func stop_shake() -> void:
	Globals.get_camera().offset = Vector2(0, 0)
	
func get_random_offset(delta: float) -> Vector2:
	noise_i += delta * shake_speed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)
