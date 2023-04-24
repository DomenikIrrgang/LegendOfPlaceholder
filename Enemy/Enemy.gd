class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

func _ready() -> void:
	super()
	alias = "Slime"
	health_bar.initialize(self)
