class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

func _ready() -> void:
	super()
	alias = "Slime"
	health_bar.initialize(self)
	health.resource_value_changed.connect(check_dead)
	
func check_dead(value: int, change: int) -> void:
	print("removing enemy")
	if health.get_value() == 0:
		print("removing enemy")
		queue_free()
