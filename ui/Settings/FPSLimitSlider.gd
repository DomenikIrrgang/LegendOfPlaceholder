extends HSlider

@export
var type: GraphicsManager.Setting

@export
var editable_setting: GraphicsManager.Setting

@export
var anount_label: Label

func _ready() -> void:
	step = 1
	min_value = 5.0
	max_value = 255
	value = GraphicsManager.settings[type]
	anount_label.text = str(int(GraphicsManager.settings[type]))
	value_changed.connect(on_value_changed)
	editable = GraphicsManager.settings[editable_setting]
	GraphicsManager.graphics_setting_changed.connect(on_setting_changed)
	
func on_setting_changed(setting: GraphicsManager.Setting, value: bool) -> void:
	if setting == editable_setting:
		editable = value
	
func on_value_changed(fps: float) -> void:
	GraphicsManager.set_setting(type, fps)
	anount_label.text = str(int(fps))
