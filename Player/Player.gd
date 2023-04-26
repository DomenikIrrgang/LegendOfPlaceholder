class_name Player
extends Unit

@export
var weapon_path: String

var weapon: Weapon

# Dash
var dash: DashCharge

# Experience
signal experience_changed(change: int)

func _init() -> void:
	unit_data = GameResources.player_data
	unit_data.experience = 0
	unit_data.level = 1
	level_changed.connect(on_level_change)

func _ready() -> void:
	super()
	dash = DashCharge.new(stat_calculator)
	init_weapon()
	died.connect(on_player_died)
	pass
	
func on_player_died(player: Unit) -> void:
	print("died reloading game")
	get_tree().reload_current_scene()
	
func on_level_change(_level: int) -> void:
	var health = get_resource(ResourceType.Enum.HEALTH)
	health.set_value(health.get_maximum_value())
		
func _process(delta: float) -> void:
	super(delta)
	dash.update(delta)

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

func attack() -> AnimationPlayer:
	return weapon.attack(self)
