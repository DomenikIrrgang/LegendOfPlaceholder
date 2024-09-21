extends Label

func _ready() -> void:
	GametimeManager.ingame_time_updated.connect(func(time: float):
		text = "Time: "
		text += str(GametimeManager.get_ingame_hour()) if GametimeManager.get_ingame_hour() >= 10 else "0" + str(GametimeManager.get_ingame_hour())
		text += ":" + str(GametimeManager.get_ingame_minutes()) if GametimeManager.get_ingame_minutes() >= 10 else "0" + str(GametimeManager.get_ingame_minutes())
	)
