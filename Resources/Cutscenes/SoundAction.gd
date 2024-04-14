class_name SoundAction
extends CutsceneAction

@export
var channel: SoundManager.Channel

@export
var sound_file: AudioStream

@export
var duration: float = 0.0

func start() -> void:
	SoundManager.play_sound(channel, sound_file, duration)
	cutscene_action_finished.emit(self)
