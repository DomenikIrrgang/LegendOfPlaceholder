extends ScrollContainer

var Keybind = preload("res://ui/Settings/KeybindSetting.tscn")

@onready
var scroll_container: Container = $MarginContainer/ScrollContainer

func _ready():
	for action in InputMap.get_actions():
		if not action.contains("ui"):
			var child = Keybind.instantiate()
			scroll_container.add_child(child)
			child.init(action)
