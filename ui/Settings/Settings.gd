extends MarginContainer

@onready
var graphics = $VBoxContainer/TabContainer/Graphics/WindowMode/Options

func _ready() -> void:
	hidden.connect(on_hide)
	visibility_changed.connect(on_visibility_changed)
	
func on_visibility_changed() -> void:
	if visible:
		graphics.grab_focus()
	
func on_hide():
	SettingsManager.save_to_settings_file()

func _on_close_pressed() -> void:
	hide()
