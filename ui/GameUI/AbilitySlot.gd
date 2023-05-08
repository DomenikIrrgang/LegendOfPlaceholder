extends TextureRect

@export
var action_name: String = ""

@onready
var keybind: KeybindDisplay = $Keybind

@onready
var icon: TextureRect = $Icon

@onready
var cooldown_bar: TextureProgressBar = $CooldownBar
var cooldown_scaling_factor: float = 10.0

@onready
var charge_label: Label = $Charges

@onready
var cooldown_label: Label = $Cooldown

var ability: Ability

func _ready() -> void:
	ability = Keybinds.get_ability_for_keybind(action_name)
	if action_name == "" or ability == null:
		keybind.visible = false
		icon.visible = false
	else:
		keybind.visible = true
		keybind.set_action_name(action_name)
		ability.used.connect(ability_used)
		ability.remaining_cooldown_changed.connect(remaining_cooldown_changed)
		ability.charges_changed.connect(update_charge_label)
		cooldown_label.visible = false
		update_charge_label(0, 0)
		cooldown_bar.max_value = 100.0 * cooldown_scaling_factor
		update_cooldown()
		if (ability and ability.icon):
			icon.texture = ability.icon
			icon.visible = true
			
func update_charge_label(_charges: int, _change: int) -> void:
	if ability.get_max_charges() > 1:
		charge_label.text = str(ability.get_charges())
		charge_label.visible = true
	else:
		charge_label.visible = false
			
func update_cooldown() -> void:
	cooldown_bar.value = ability.get_cooldown_progress() * cooldown_scaling_factor
	if ability.get_remaining_cooldown() > 0.0:
		cooldown_label.visible = true
		cooldown_label.text = str(ceil(ability.get_remaining_cooldown()))
	else:
		cooldown_label.visible = false
			
func ability_used(_ability: Ability) -> void:
	update_cooldown()
	
func remaining_cooldown_changed(_remaining_cooldown: float, _cooldown: float) -> void:
	update_cooldown()	
	
			
			
