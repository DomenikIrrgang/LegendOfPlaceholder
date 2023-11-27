class_name StatusEffect
extends Resource

@export
var alias: String = ""

@export
var type: StatusEffectType.Enum = StatusEffectType.Enum.BUFF

@export
var description: String = ""

@export
var dispellable: bool

@export
var has_duration: bool = true

@export
var duration: float = 10.0

@export
var effect: StatusEffectScript

@export
var animation: StatusEffectAnimation

@export
var icon: Texture
