class_name Player
extends Unit

@onready
var light_box: PointLight2D = $LightBox

@onready
var interaction: Area2D = $InteractionArea

@export
var weapon_path: String

var weapon: Weapon

# Experience
signal experience_changed(change: int)

# Gear
var gear_slots: Array[Gear] = []

signal gear_slot_changed(slot: Gear.Slot, gear: Gear)
signal unequipped_gear(gear: Gear)
signal equipped_gear(gear: Gear)

func equip_gear(gear: Gear) -> bool:
	return equip_gear_in_slot(gear.slot, gear)
	
func has_gear_equipped(gear: Gear) -> bool:
	return gear_slots[gear.slot] != null and gear_slots[gear.slot] == gear

func equip_gear_in_slot(slot: Gear.Slot, gear: Gear) -> bool:
	if gear.slot == slot:
		if gear_slots[slot] != null:
			unequip_gear_in_slot(slot)
		gear_slots[slot] = gear
		for gear_effect in gear.gear_effects:
			gear_effect.on_gear_equipped(gear, self)
		equipped_gear.emit(gear)
		gear_slot_changed.emit(slot, gear)
		return true
	return false
	
func unequip_gear_in_slot(slot: Gear.Slot) -> bool:
	if gear_slots[slot] != null:
		for gear_effect in gear_slots[slot].gear_effects:
			gear_effect.on_gear_unequipped(gear_slots[slot], self)
		var tmp_gear = gear_slots[slot]
		gear_slots[slot] = null
		gear_slot_changed.emit(slot, null)
		unequipped_gear.emit(tmp_gear)
		return true
	return false

func _init() -> void:
	gear_slots.resize(Gear.Slot.keys().size())
	unit_data = GameResources.player_data
	unit_data.experience = 0
	unit_data.level = 1
	level_changed.connect(on_level_change)

func _ready() -> void:
	super()
	resources[ResourceType.Enum.DASH_CHARGE] = DashCharge.new(self)
	init_weapon()
	died.connect(on_player_died)
	Globals.get_environment_light().energy_changed.connect(on_energy_changed)
	for ability in get_abilities():
		ability.on_assign(self)
		
func on_energy_changed(energy) -> void:
	if energy > 0.6:
		light_box.energy = energy - 0.6
	else:
		light_box.energy = 0.0
	
func get_abilities() -> Array[Ability]:
	return Keybinds.get_abilities() 
	
func on_player_died(_player: Unit) -> void:
	respawn()
	
func respawn() -> void:
	alive = true
	for resource in resources:
		if resource != null:
			resource.reset()
	for ability in get_abilities():
		ability.reset()
	if pushback_tween != null:
		pushback_tween.pause()	
		pushback_tween.kill()
	last_pushback = Time.get_unix_time_from_system()
	pushback_velocity = Vector2(0.0, 0.0)
	SaveFileManager.load_save_file()
	
func level_up() -> void:
	gain_experience(experience_needed_for_next_level())
	
func on_level_change(_level: int) -> void:
	var health = get_resource(ResourceType.Enum.HEALTH)
	health.set_value(health.get_maximum_value())
		
func _process(delta: float) -> void:
	super(delta)
	get_resource(ResourceType.Enum.DASH_CHARGE).update(delta)
	
func get_total_experience() -> int:
	return unit_data.experience
	
func set_experience(value: int) -> void:
	unit_data.experience = value

func gain_experience(amount: int) -> void:
	if (get_level() < max_level):
		unit_data.experience += amount
		while (experience_needed_for_next_level() - current_experience() <= 0):
			set_level(get_level() + 1)
		experience_changed.emit(amount)
	
func current_experience() -> int:
	return unit_data.experience - experience_needed_for_level(get_level() - 1)
	
func experience_needed_for_next_level() -> int:
	return experience_needed_for_level(get_level()) - experience_needed_for_level(get_level() - 1)
	
func experience_needed_for_level(_level: int) -> int:
	return _level * _level * 100
	
func init_weapon() -> void:
	var weapon_scene: PackedScene = load(weapon_path)
	weapon = weapon_scene.instantiate()
	add_child(weapon)
	
func dash() -> void:
	state.transition_to("Dash")

func attack() -> void:
	state.transition_to("Attack")
	
func get_facing_direction() -> Vector2:
	var x = 0
	var y = 0
	if direction == Direction.RIGHT:
		x = 1
	if direction == Direction.DOWN:
		y = 1
	if direction == Direction.LEFT:
		x = -1
	if direction == Direction.UP:
		y = -1
	return Vector2(x, y)
