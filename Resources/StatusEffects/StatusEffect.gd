class_name StatusEffect
extends Resource

@export
var alias: String = ""

@export
var type: StatusEffectType.Enum = StatusEffectType.Enum.BUFF

@export_multiline
var description: String = ""

@export
var dispellable: bool

@export
var has_duration: bool = true

@export
var duration: float = 10.0

@export
var unique: bool = false

@export
var stackable: bool = false

@export
var max_stacks: int = 1

@export
var effects: Array[StatusEffectScript] = []

@export
var animation: StatusEffectAnimation

@export
var icon: Texture

