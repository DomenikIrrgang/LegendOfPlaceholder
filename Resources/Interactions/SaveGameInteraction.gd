class_name SaveGameInteraction
extends Interaction

func start() -> void:
	Globals.get_player().reset_resources()
	SaveFileManager.save_to_save_file()
