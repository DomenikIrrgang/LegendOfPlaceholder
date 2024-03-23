class_name SaveGameInteraction
extends Interaction

func start() -> void:
	SaveFileManager.save_to_save_file()
