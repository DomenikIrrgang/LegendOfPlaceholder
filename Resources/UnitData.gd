class_name UnitData
extends Resource

@export_category("UnitData - Basic Settings")
@export
var alias: String = ""

@export
var dialog_texture: Texture

@export
var level: int = 1

@export
var is_friendly: bool = false

@export_category("UnitData - Combat Settings")
@export
var base_movement_speed: float = 30.0

@export
var mass: float = 50

@export
var knockbackable: bool = true

@export
var stats: Array[StatAssignment] = []
