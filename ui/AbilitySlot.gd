extends TextureRect

@export
var action_name: String = ""

@onready
var keybind: KeybindDisplay = $Keybind

@onready
var icon: TextureRect = $Icon

func _ready() -> void:
	if action_name == "":
		keybind.visible = false
		icon.visible = false
	else:
		keybind.set_action_name(action_name)
		var ability = Keybinds.get_ability_for_keybind(action_name)
		if (ability and ability.icon):
			icon.texture = ability.icon
