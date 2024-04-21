class_name Zone
extends Node2D

@export
var zone_name: String

@export
var environment_light_energy: float

@export
var background_music: AudioStream

func _ready() -> void:
	Globals.get_environment_light().change_energy(environment_light_energy, 0.0)
	if background_music:
		SoundManager.play_sound(SoundManager.Channel.BACKGROUND_MUSIC, background_music)
