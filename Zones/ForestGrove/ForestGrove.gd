extends Zone

func _ready() -> void:
	super()
	if GameStateManager.get_flag(GameFlag.Enum.INTRO_LEFT_HOUSE):
		Globals.get_environment_light().change_energy(0.95, 0)
