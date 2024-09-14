extends Label


func _ready() -> void:
	GraphicsManager.graphics_setting_changed.connect(on_graphics_setting_changed)
	visible = GraphicsManager.settings[GraphicsManager.Setting.FPS_COUNTER_SHOWN]

func on_graphics_setting_changed(setting: GraphicsManager.Setting, value: bool) -> void:
	if setting == GraphicsManager.Setting.FPS_COUNTER_SHOWN:
		visible = value

func _process(delta: float) -> void:
	text = "FPS: " + str(Engine.get_frames_per_second())
