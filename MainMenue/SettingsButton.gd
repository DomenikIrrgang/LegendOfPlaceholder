extends Button

@onready
var settings = $"../../../../../Settings"

@onready
var center = $"../../../../../CenterContainer"

func _ready() -> void:
	pressed.connect(on_pressed)
	settings.hidden.connect(on_settings_hidden)
	
func on_pressed() -> void:
	settings.show()
	center.hide()
	get_parent().hide()

func on_settings_hidden() -> void:
	center.show()
	get_parent().show()
	grab_focus()
