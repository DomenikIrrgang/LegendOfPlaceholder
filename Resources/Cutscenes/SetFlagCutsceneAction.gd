class_name SetFlagCutsceneAction
extends CutsceneAction

@export
var flag: GameFlag.Enum

@export
var value: bool = false

func start() -> void:
	GameStateManager.set_flag(flag, value)
	cutscene_action_finished.emit(self)
