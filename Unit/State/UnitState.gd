class_name UnitState
extends State

var movement_strategy: UnitMovementStrategy
var unit: Unit

func enter(_data := {}) -> void:
	if movement_strategy == null:
		movement_strategy = UnitMovementStrategy.new(unit)
	unit.movement_strategy = movement_strategy

func _ready() -> void:
	await owner.ready
	unit = self.get_parent().get_parent() as Unit
	assert(unit != null)

func get_unpause_state() -> String:
	return name
