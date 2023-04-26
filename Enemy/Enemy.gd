class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

func _ready() -> void:
	super()
	health_bar.initialize(self)
	health.resource_value_changed.connect(check_dead)
	
func check_dead(value: int, change: int) -> void:
	if health.get_value() == 0:
		queue_free()
