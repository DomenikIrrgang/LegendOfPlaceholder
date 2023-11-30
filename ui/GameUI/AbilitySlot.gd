class_name AbilitySlot
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

@onready
var highlight: NinePatchRect = $Highlight

var ability: Ability

func _ready() -> void:
	set_ability(Keybinds.get_ability_for_keybind(action_name))
	Globals.get_drag_and_drop().on_start_dragging.connect(on_start_dragging)
	Globals.get_drag_and_drop().on_stop_dragging.connect(on_stop_dragging)

func set_ability(_ability: Ability) -> void:
	ability = _ability
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
			
func on_start_dragging() -> void:
	var drag_and_drop = Globals.get_drag_and_drop()
	if drag_and_drop.data.has("ability"):
		highlight.visible = true
					
func on_stop_dragging() -> void:
	highlight.visible = false
			
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
		if ability.get_remaining_cooldown() < 1.0:
			cooldown_label.text = str(snapped(ability.get_remaining_cooldown(), 0.1))
		else:
			cooldown_label.text = str(floor(ability.get_remaining_cooldown()))
	else:
		cooldown_label.visible = false
			
func ability_used(_ability: Ability) -> void:
	update_cooldown()
	
func remaining_cooldown_changed(_remaining_cooldown: float, _cooldown: float) -> void:
	update_cooldown()	

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		var drag_and_drop = Globals.get_drag_and_drop()
		if drag_and_drop.is_dragging() == true:
			if drag_and_drop.data.has("ability"):
				if drag_and_drop.data.has("slot") and drag_and_drop.data.slot != null:
					var slot = drag_and_drop.data.slot
					Keybinds.swap_keybound_abilities(action_name, slot.action_name)
					slot.set_ability(ability)
				else:
					Keybinds.keybind_ability(action_name, drag_and_drop.data.ability)
				set_ability(drag_and_drop.data.ability)
				drag_and_drop.stop_dragging()
		else:
			if Globals.get_drag_and_drop().is_dragging() and Globals.get_drag_and_drop().data.has("ability") and Globals.get_drag_and_drop().data.ability == ability:
				Globals.get_drag_and_drop().stop_dragging()
			else:
				Globals.get_drag_and_drop().stop_dragging()
				Globals.get_drag_and_drop().start_dragging({
						"ability": ability,
						"slot": self
					}, ability.icon)
