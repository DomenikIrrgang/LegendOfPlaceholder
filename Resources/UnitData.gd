class_name UnitData
extends Resource

@export_category("Basic Settings")
@export
var alias: String = ""

@export
var level: int = 1

@export_category("Combat Settings")
@export
var base_movement_speed: float = 30.0

@export
var mass: float = 50

@export
var knockbackable: bool = true

@export
var stats: Array[StatAssignment] = []
