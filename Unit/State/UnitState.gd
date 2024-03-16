class_name UnitState
extends State

var unit: Unit

func _ready() -> void:
	await owner.ready
	unit = self.get_parent().get_parent() as Unit
	assert(unit != null)
