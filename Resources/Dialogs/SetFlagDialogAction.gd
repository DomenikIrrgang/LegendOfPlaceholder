class_name SetFlagDialogAction
extends DialogAction

@export
var flag: GameFlag.Enum

@export
var flag_value: bool

func start() -> void:
	GameStateManager.set_flag(flag, flag_value)
	dialog_action_finished.emit(self)
