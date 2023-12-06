class_name Player
extends Unit

@onready
var movement_state: StateMachine = $MovementState

@onready
var light_box: PointLight2D = $LightBox

@export
var weapon_path: String

var weapon: Weapon

# Experience
signal experience_changed(change: int)

func _init() -> void:
	unit_data = GameResources.player_data
	unit_data.experience = 0
	unit_data.level = 1
	level_changed.connect(on_level_change)

func _ready() -> void:
	super()
	resources[ResourceType.Enum.DASH_CHARGE] = DashCharge.new(stat_calculator)
	resources[ResourceType.Enum.MANA] = Mana.new(stat_calculator)
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
	for ability in get_abilities():
		ability.reset()
		ability.on_unassign(self)
	get_tree().reload_current_scene()
	
func level_up() -> void:
	gain_experience(experience_needed_for_next_level())
	
func on_level_change(_level: int) -> void:
	var health = get_resource(ResourceType.Enum.HEALTH)
	health.set_value(health.get_maximum_value())
		
func _process(delta: float) -> void:
	super(delta)
	get_resource(ResourceType.Enum.DASH_CHARGE).update(delta)

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
	movement_state.transition_to("Dash")

func attack() -> void:
	movement_state.transition_to("Attack")
	
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
