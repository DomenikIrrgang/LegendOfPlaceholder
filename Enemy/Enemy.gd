class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

func _ready() -> void:
	super()
	health_bar.initialize(self)
	movement_strategy = FollowMovementStrategy.new(self, Globals.get_player())
	died.connect(on_died)
	
func on_died(_enemy: Unit) -> void:
	Globals.get_player().gain_experience(unit_data.experience)
	queue_free()
	
func add_timed_function(callback: Callable, cooldown_min: float, cooldown_max: float) -> float:
	return 0.0
