extends PointLight2D

@export
var max_energy: float = 1.0

@export
var min_energy: float = 0.7

@export
var max_size: float = 1.0

@export
var min_size: float =  0.7

@export
var speed: float = 5.0

var rising: bool = false

func _ready() -> void:
	energy = min_energy
	texture_scale = min_size
	rising = true

func _process(delta: float) -> void:
	if energy >= max_energy:
		rising = false
	if energy <= min_energy:
		rising = true
	if rising:
		energy += (max_energy - min_energy) * speed * delta
		texture_scale += (max_size - min_size) * speed * delta
	else:
		energy -= (max_energy - min_energy) * speed * delta
		texture_scale -= (max_size - min_size) * speed * delta
