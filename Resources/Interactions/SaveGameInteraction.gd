class_name SaveGameInteraction
extends Interaction

func start() -> void:
	Globals.get_player().reset_resources()
	SaveFileManager.save_to_save_file()
	SoundManager.play_sound(SoundManager.Channel.SOUND_EFFECT, load("res://assets/sound/effects/crystal_save.wav"))
