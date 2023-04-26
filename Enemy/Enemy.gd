class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

func _ready() -> void:
	super()
	health_bar.initialize(self)
	movement_strategy = FollowMovementStrategy.new(self, get_node("../Player"))
	died.connect(on_died)
	
func on_died() -> void:
	get_node("../Player").gain_experience(unit_data.experience)
	queue_free()
