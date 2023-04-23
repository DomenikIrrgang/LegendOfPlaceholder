class_name Enemy
extends Unit

# UI
@onready
var health_bar
var HealthBar = preload("res://ui/unit/UnitHpBar.tscn")

func _ready() -> void:
	super()
	alias = "Slime"
	health_bar = HealthBar.instantiate()
	health_bar.position.y = -15
	add_child(health_bar)
	health_bar.initialize(self)
